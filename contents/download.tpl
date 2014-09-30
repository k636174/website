<h1>ダウンロード</h1>

<h2>RPMをyumリポジトリーからインストール</h2>

<p>
	Hatoholのyumリポジトリーからインストールを行います。原則としてCentOS (またはRedHat及びそのクローン) のバージョン6専用です。<br>
このyumリポジトリーは現在ベータ版です。予告なくURLやパッケージ、その他に対して、変更が行われる可能性があります。
</p>

<pre><kbd class="shell"><span class="shellline">wget -P /etc/yum.repos.d/ http://project-hatohol.github.io/repo/hatohol.repo</span>
<span class="shellline">yum install hatohol hatohol-client</span>
</kbd></pre>

<h2>RPMを一つ一つインストール</h2>

<p>
	yumリポジトリーを用いずに、yum installを用いてダウンロード・インストールを行うことも可能です。<br>
	yumリポジトリーを用いる方法と同様、原則としてCentOS (またはRedHat及びそのクローン) のバージョン6専用です。
</p>

<pre><kbd class="shell"><span class="shellline">yum install https://github.com/project-hatohol/json-glib-for-distribution/raw/master/RPMS/x86_64/json-glib-0.12.6-1PH.x86_64.rpm</span>
<span class="shellline">yum install https://github.com/project-hatohol/Django-for-distribution/raw/master/dist/Django-1.5.3-1.noarch.rpm</span>

<span class="shelline">yum install https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-lib-common-14.06-4.el6.x86_64.rpm</span>
<span class="shelline">yum install https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-lib-arm-plugin-14.06-4.el6.x86_64.rpm</span>
<span class="shelline">yum install https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-14.06-4.el6.x86_64.rpm</span>
<span class="shelline">yum install https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-client-14.06-4.el6.x86_64.rpm</span></pre>

<h2>RPMをダウンロード</h2>
<p>Hatohol及び、Project Hatoholが提供する依存パッケージのRPMは以下からダウンロードすることができます。</p>
<ul>
	<li><a href="https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-lib-common-14.06-4.el6.x86_64.rpm">Common library package (server)</a>
	<li><a href="https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-lib-arm-plugin-14.06-4.el6.x86_64.rpm">Arm Plugin package (server)</a>
	<li><a href="https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-client-14.06-4.el6.x86_64.rpm">Hatohol Server (hatohol)</a></li>
	<li><a href="https://github.com/project-hatohol/hatohol-packages/raw/master/RPMS/14.06/hatohol-client-14.06-4.el6.x86_64.rpm">Hatohol Client (hatohol-client)</a></li>
	<li><a href="https://github.com/project-hatohol/json-glib-for-distribution/raw/master/RPMS/x86_64/json-glib-0.12.6-1PH.x86_64.rpm">json-glib</a></li>
	<li><a href="https://github.com/project-hatohol/Django-for-distribution/raw/master/dist/Django-1.5.3-1.noarch.rpm">Django</a></li>
</ul>

<h2>ソースコードをダウンロード</h2>
		<p>ソースコードはGitHubにありますので、git cloneが可能です。Ubuntuや、他のLinuxディストリビューションで試したい場合は、ソースコードからコンパイルして下さい。</p>
		<pre><kbd class="shell">git clone https://github.com/project-hatohol/hatohol.git</kbd></pre>
		<p>また、以下のリンクから、最新のmasterをZip形式でダウンロードすることも可能です。</p>

		<p><a href="https://github.com/project-hatohol/hatohol/archive/master.zip" class="download download-small">ソースコードをダウンロード</a></p>

