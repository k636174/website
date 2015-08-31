#! /usr/bin/env python3
# coding: utf-8

import markdown
import os
import shutil
import subprocess
import sys

def main():
	if len(sys.argv) > 1:
		for i in range(len(sys.argv)-1):
			if sys.argv[i+1] == "--output":
				output = sys.argv[i+2]

	else: #  no argument given
		print("""Argument required:
		./gen.py --output [Output Directory]
		""")
		exit()

	prjdir = os.path.dirname(__file__)

	if os.path.isdir(output):
		shutil.rmtree(output)

	with open("%s/layouts/header.tpl" % prjdir, "r") as header_file:
		header = header_file.read()

	with open("%s/layouts/footer.tpl" % prjdir, "r") as footer_file:
		footer = footer_file.read()

	gen_html("%s/contents" % prjdir, output, header, footer)

def gen_html(walk_dir, outpath_root, header, footer):
	# Compile .scss files
	sass_cmd = "bundle exec sass --style expanded --update %s:%s" % (walk_dir, outpath_root)
	print(sass_cmd)
	subprocess.call(sass_cmd, shell=True)

	for (dirpath, dirnames, filenames) in os.walk(walk_dir):
		outpath = os.path.join(outpath_root, os.path.relpath(dirpath, walk_dir))

		if not os.path.isdir(outpath):
			os.makedirs(outpath)

		for filename in filenames:
			if filename.endswith(".scss"):
				pass # Don't copy .scss files
			elif filename.endswith(".odg"):
				outfile = os.path.join(outpath, filename.replace(".odg", ".png"))
				srcfile = os.path.join(dirpath, filename)
				result = subprocess.call("unoconv -f png -o %s %s" % (outpath, srcfile), shell=True)

				if result is 0:
					print("Copied %s to %s" % (os.path.abspath(srcfile), os.path.abspath(outfile)))
				else: # result is 1
					print("Failed to copy %s to %s" % (os.path.abspath(srcfile), os.path.abspath(outfile)))
			elif filename.endswith(".md") or filename.endswith(".tpl"):
				with open(os.path.join(dirpath, filename), "r") as content_file:
					content = content_file.read()

					if filename.endswith(".md"):
						content = markdown.markdown(content, output_format="html5")

					if filename == "index.tpl":
						outfile = os.path.join(outpath, filename.replace(".tpl", ".html"))
					elif filename == "index.md":
						outfile = os.path.join(outpath, filename.replace(".md", ".html"))
					else: # if filename != "index.tpl"
						outfile = os.path.join(outpath, filename.replace(".tpl", "").replace(".md", ""), "index.html")

						if not os.path.isdir(os.path.dirname(outfile)):
							os.makedirs(os.path.dirname(outfile))

					html = "%s%s%s" % (header, content, footer)

					with open(os.path.join(outfile), "w+") as output_file:
						output_file.write(html)

					print("Copied %s to %s" % (os.path.abspath(content_file.name), os.path.abspath(outfile)))
			else:
				shutil.copy(os.path.join(dirpath, filename), os.path.join(outpath, filename))

if __name__ == "__main__":
	main()
