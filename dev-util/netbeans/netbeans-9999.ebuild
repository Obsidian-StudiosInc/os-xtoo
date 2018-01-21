# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jdk-9:*"

ANTLR3_SLOT="3"
ANTLR4_SLOT="4"
ASM_SLOT="6"
ECLIPSE_SLOT="4.7"
LUCENE_SLOT="3"
MYLYN_SLOT="3"
OSGI_SLOT="6"
WIKI_SLOT="3"
XERCES_SLOT="2"

RDEPEND="
	dev-java/antlr:${ANTLR3_SLOT}
	dev-java/antlr:${ANTLR4_SLOT}
	dev-java/asm:${ASM_SLOT}
	dev-java/freemarker:0
	dev-java/jsr305:0
	dev-java/lucene-core:${LUCENE_SLOT}
	dev-java/nb-cmake-completion:0
	dev-java/nb-darcula:0
	~dev-java/${PN}-ant-browsetask-${PV}:${SLOT}
	~dev-java/${PN}-ant-grammar-${PV}:${SLOT}
	~dev-java/${PN}-ant-kit-${PV}:${SLOT}
	~dev-java/${PN}-api-htmlui-${PV}:${SLOT}
	~dev-java/${PN}-apisupport-harness-${PV}:${SLOT}
	~dev-java/${PN}-apisupport-project-${PV}:${SLOT}
	~dev-java/${PN}-apisupport-wizards-${PV}:${SLOT}
	~dev-java/${PN}-autoupdate-cli-${PV}:${SLOT}
	~dev-java/${PN}-autoupdate-pluginimporter-${PV}:${SLOT}
	~dev-java/${PN}-bugtracking-bridge-${PV}:${SLOT}
	~dev-java/${PN}-core-browser-${PV}:${SLOT}
	~dev-java/${PN}-core-execution-${PV}:${SLOT}
	~dev-java/${PN}-core-io-ui-${PV}:${SLOT}
	~dev-java/${PN}-core-kit-${PV}:${SLOT}
	~dev-java/${PN}-core-multitabs-project-${PV}:${SLOT}
	~dev-java/${PN}-core-netigso-${PV}:${SLOT}
	~dev-java/${PN}-core-network-${PV}:${SLOT}
	~dev-java/${PN}-core-osgi-${PV}:${SLOT}
	~dev-java/${PN}-core-output2-${PV}:${SLOT}
	~dev-java/${PN}-core-ui-${PV}:${SLOT}
	~dev-java/${PN}-css-prep-${PV}:${SLOT}
	~dev-java/${PN}-css-visual-${PV}:${SLOT}
	~dev-java/${PN}-dlight-nativeexecution-nb-${PV}:${SLOT}
	~dev-java/${PN}-dlight-terminal-${PV}:${SLOT}
	~dev-java/${PN}-editor-actions-${PV}:${SLOT}
	~dev-java/${PN}-editor-bookmarks-${PV}:${SLOT}
	~dev-java/${PN}-editor-global-format-${PV}:${SLOT}
	~dev-java/${PN}-editor-fold-nbui-${PV}:${SLOT}
	~dev-java/${PN}-editor-indent-project-${PV}:${SLOT}
	~dev-java/${PN}-editor-indent-support-${PV}:${SLOT}
	~dev-java/${PN}-editor-plain-${PV}:${SLOT}
	~dev-java/${PN}-editor-macros-${PV}:${SLOT}
	~dev-java/${PN}-editor-mimelookup-impl-${PV}:${SLOT}
	~dev-java/${PN}-editor-search-${PV}:${SLOT}
	~dev-java/${PN}-editor-settings-storage-${PV}:${SLOT}
	~dev-java/${PN}-editor-tools-storage-${PV}:${SLOT}
	~dev-java/${PN}-extbrowser-${PV}:${SLOT}
	~dev-java/${PN}-git-${PV}:${SLOT}
	~dev-java/${PN}-html-custom-${PV}:${SLOT}
	~dev-java/${PN}-html-editor-${PV}:${SLOT}
	~dev-java/${PN}-html-parser-${PV}:${SLOT}
	~dev-java/${PN}-ide-${PV}:${SLOT}
	~dev-java/${PN}-ide-kit-${PV}:${SLOT}
	~dev-java/${PN}-java-api-common-${PV}:${SLOT}
	~dev-java/${PN}-java-completion-${PV}:${SLOT}
	~dev-java/${PN}-java-editor-base-${PV}:${SLOT}
	~dev-java/${PN}-java-editor-lib-${PV}:${SLOT}
	~dev-java/${PN}-java-freeform-${PV}:${SLOT}
	~dev-java/${PN}-java-guards-${PV}:${SLOT}
	~dev-java/${PN}-java-platform-ui-${PV}:${SLOT}
	~dev-java/${PN}-java-project-${PV}:${SLOT}
	~dev-java/${PN}-java-source-ant-${PV}:${SLOT}
	~dev-java/${PN}-java-source-compat8-${PV}:${SLOT}
	~dev-java/${PN}-javahelp-${PV}:${SLOT}
	~dev-java/${PN}-lexer-nbbridge-${PV}:${SLOT}
	~dev-java/${PN}-libs-antlr3-runtime-${PV}:${SLOT}
	~dev-java/${PN}-libs-antlr4-runtime-${PV}:${SLOT}
	~dev-java/${PN}-libs-asm-${PV}:${SLOT}
	~dev-java/${PN}-libs-freemarker-${PV}:${SLOT}
	~dev-java/${PN}-localhistory-${PV}:${SLOT}
	~dev-java/${PN}-localtasks-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-linux-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-nio2-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-ui-${PV}:${SLOT}
	~dev-java/${PN}-o-n-swing-dirchooser-${PV}:${SLOT}
	~dev-java/${PN}-o-n-upgrader-${PV}:${SLOT}
	~dev-java/${PN}-openide-compat-${PV}:${SLOT}
	~dev-java/${PN}-openide-filesystems-compat8-${PV}:${SLOT}
	~dev-java/${PN}-openide-options-${PV}:${SLOT}
	~dev-java/${PN}-options-keymap-${PV}:${SLOT}
	~dev-java/${PN}-parsing-nb-${PV}:${SLOT}
	~dev-java/${PN}-parsing-ui-${PV}:${SLOT}
	~dev-java/${PN}-progress-ui-${PV}:${SLOT}
	~dev-java/${PN}-project-ant-ui-${PV}:${SLOT}
	~dev-java/${PN}-project-libraries-ui-${PV}:${SLOT}
	~dev-java/${PN}-project-spi-intern-impl-${PV}:${SLOT}
	~dev-java/${PN}-projectapi-nb-${PV}:${SLOT}
	~dev-java/${PN}-projectui-${PV}:${SLOT}
	~dev-java/${PN}-projectui-buildmenu-${PV}:${SLOT}
	~dev-java/${PN}-properties-syntax-${PV}:${SLOT}
	~dev-java/${PN}-spi-actions-${PV}:${SLOT}
	~dev-java/${PN}-team-ide-${PV}:${SLOT}
	~dev-java/${PN}-templatesui-${PV}:${SLOT}
	~dev-java/${PN}-uihandler-${PV}:${SLOT}
	~dev-java/${PN}-updatecenters-${PV}:${SLOT}
	~dev-java/${PN}-utilities-project-${PV}:${SLOT}
	~dev-java/${PN}-versioning-indexingbridge-${PV}:${SLOT}
	~dev-java/${PN}-versioning-masterfs-${PV}:${SLOT}
	~dev-java/${PN}-versioning-system-cvss-installer-${PV}:${SLOT}
	~dev-java/${PN}-xml-catalog-ui-${PV}:${SLOT}
	~dev-java/${PN}-xml-multiview-${PV}:${SLOT}
	~dev-java/${PN}-xml-schema-completion-${PV}:${SLOT}
	~dev-java/${PN}-xml-text-obsolete90-${PV}:${SLOT}
	~dev-java/${PN}-xml-tools-java-${PV}:${SLOT}
	~dev-java/${PN}-xml-xdm-${PV}:${SLOT}
	~dev-java/${PN}-xsl-${PV}:${SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	>=virtual/jdk-9:*
"

S="${S%*${PN}}"

#o.n.bootstrap/launcher/unix/nbexec
NB_LAUNCHER="ide/launcher/unix/${PN}"

src_prepare() {
	default
	sed -i -e 's|"${userdir}"/etc|/etc/'${PN}'-'${SLOT}'|' -e 's|$X/||g' \
		-e '/-clusters/d' -e '/netbeans\.accept_license/d' \
		${NB_LAUNCHER} \
		|| die "Failed to sed/update launcher script"
}

src_compile() {
:
}

symlink_jars() {
	local j
	for j in "${@:2}"; do
		dosym "../../${PN}-${j}-${SLOT}/lib/${PN}-${j}.jar" \
			"${1}/${PN}-${j}.jar"
	done
}

symlink_libs() {
	local l p
	for p in "${@}"; do
		l="$(jem -p ${p})"
		[[ -z ${l} ]] && die "Jar not found for ${p}"
		dosym "${l/\/usr\/share\//../../}" \
			"/usr/share/${PN}-${SLOT}/lib/${l##*/}"
	done
}

src_install() {
	local icon icon_dir j jdir jars jars_short my_pn
	my_pn="netbeans-${SLOT}"

	dodir /etc/${my_pn}
	insinto /etc/${my_pn}
	doins ide/launcher/${PN}.conf
	doins ide/launcher/${PN}.clusters

	dodir /usr/share/${my_pn}/{bin,core,docs,lib,modules}
	dodir /usr/share/${my_pn}/config/Module{s,AutoDeps}

	insinto /usr/share/${my_pn}
	doins core.kit/release/VERSION.txt
#	newins	"?" moduleCluster.properties

	exeinto /usr/share/${my_pn}/bin
	doexe ${NB_LAUNCHER}

	exeinto /usr/share/${my_pn}/lib
	doexe o.n.bootstrap/launcher/unix/nbexec

	# symlink etc and launchers/bins
	dosym ../../../etc/${my_pn} /usr/share/${my_pn}/etc
	dosym ../share/${my_pn}/bin/${PN} /usr/bin/${my_pn}
	dosym ../share/${my_pn}/lib/nbexec /usr/bin/nbexec-${SLOT}

	# symlink keystore
	dosym ../../${PN}-updatecenters-${SLOT}/ks/ide.ks \
		/usr/share/${my_pn}/core/ide.ks

	# symlink jars in core
	jdir=lib # use lib vs core for now
	jars=( core-startup core-startup-base libs-asm o-n-core )
	symlink_jars "/usr/share/${my_pn}/${jdir}" ${jars[@]}
	dosym ../../asm-${ASM_SLOT}/lib/asm.jar \
		/usr/share/${my_pn}/${jdir}/asm.jar
	dosym ../../jsr305/lib/jsr305.jar \
		/usr/share/${my_pn}/${jdir}/jsr305.jar

	# symlink jars in lib
	jars=( filesystems filesystems-compat8 modules util util-lookup util-ui )
	jars=( ${jars[@]/#/openide-} o-n-bootstrap o-n-upgrader )
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]}

	# symlink 3rd party
	jars_short=( contenttype jobs net runtime )
	jars=( ${jars_short[@]/#/core-} )

	jars_short=( app common preferences registry security )
	jars+=( ${jars_short[@]/#/equinox-} jdt-annotation osgi osgi-services )
	jars=( ${jars[@]/%/-${ECLIPSE_SLOT}} )

	jars_short=( core net repositories-core )
	jars_short=( ${jars_short[@]/#/mylyn-commons-} mylyn-tasks-core )
	jars+=( ${jars_short[@]/%/-${MYLYN_SLOT}} mylyn-wikitext-${WIKI_SLOT} )
	jars=( ${jars[@]/#/eclipse-} ) # eclipse jars needed by localtasks

	jars_short=( core jsch sshagent usocket-jna )
	jars+=( ${jars_short[@]/#/jsch-agent-proxy-} )

	jars_short=( "" "-boot" "-boot-fx" "-geo" "-json" )
	jars+=( ${jars_short[@]/#/net-java-html} )

	jars+=(
		darcula eclipse-jgit freemarker htmlparser iconloader
		intellij-platform-annotations javaewah jsch json-simple
		lucene-core-${LUCENE_SLOT} nb-cmake-completion nb-darcula
		osgi-core-api-${OSGI_SLOT} xerces-${XERCES_SLOT}
		xml-commons-resolver slf4j-api
	)
	symlink_libs ${jars[@]}

	dosym ../../antlr-${ANTLR3_SLOT}/lib/antlr-runtime.jar \
		/usr/share/${my_pn}/lib/antlr3-runtime.jar

	dosym ../../antlr-${ANTLR4_SLOT}/lib/antlr-runtime.jar \
		/usr/share/${my_pn}/lib/antlr4-runtime.jar

#	java-netbeans_create-module-xml "osgi-core-api" lib 0

	# symlink jars in modules
	jars_short=( browsetask freeform grammar kit )
	jars=( ${jars_short[@]/#/ant-} )

	jars_short=(
		annotations-common htmlui intent io progress progress-nb java
		java-classpath templates xml xml-ui
	)
	jars+=( ${jars_short[@]/#/api-} )

	jars_short=( harness project wizards )
	jars+=( ${jars_short[@]/#/apisupport-} )

	jars_short=( cli pluginimporter services ui )
	jars+=( ${jars_short[@]/#/autoupdate-} )

	jars_short=( "" "-bridge" "-commons" )
	jars+=( ${jars_short[@]/#/bugtracking} )

	jars_short=(
		browser execution ide io-ui kit multitabs multitabs-project
		multiview netigso network osgi output2 windows ui
	)
	jars+=( ${jars_short[@]/#/core-} )

	jars_short=( api types )
	jars+=( ${jars_short[@]/#/csl-} )

	jars_short=( editor lib model prep visual )
	jars+=( ${jars_short[@]/#/css-} )

	jars_short=( nativeexecution nativeexecution-nb terminal )
	jars+=( ${jars_short[@]/#/dlight-} )

	jars_short=(
		actions bookmarks bracesmatching breadcrumbs codetemplates
		completion deprecated-pre65formatting document errorstripe
		errorstripe-api fold fold-nbui global-format guards indent
		indent-support lib lib2 macros mimelookup mimelookup-impl
		plain plain-lib search settings settings-lib settings-storage
		structure tools-storage util
	)
	jars+=( ${jars_short[@]/#/editor-} )

	jars_short=( browser execution execution-base )
	jars+=( ${jars_short[@]/#/ext} )

	jars_short=( "" "-custom" "-editor" "-editor-lib" "-lexer" "-parser" )
	jars+=( ${jars_short[@]/#/html} )

	jars_short=(
		api-common completion editor-base editor-lib freeform guards
		lexer platform platform-ui preprocessorbridge project project-ui
		source source-ant source-base source-compat8 sourceui
	)
	jars+=( ${jars_short[@]/#/java-} )

	jars_short=( nbjavac terminalemulator uihandler )
	jars+=( ${jars_short[@]/#/lib-} )

	jars_short=(
		antlr3-runtime antlr4-runtime freemarker jsch-agentproxy git
	)
	jars+=( ${jars_short[@]/#/libs-} )

	jars_short=( "" "-linux" -"nio2" "-ui" )
	jars+=( ${jars_short[@]/#/masterfs} )

	jars_short=( dirchooser outline plaf tabcontrol )
	jars+=( ${jars_short[@]/#/o-n-swing-} )

	jars_short=(
		actions awt compat dialogs execution explorer filesystems-nb
		io loaders nodes options text windows
	)
	jars+=( ${jars_short[@]/#/openide-} )

	jars_short=( api editor keymap )
	jars+=( ${jars_short[@]/#/options-} )

	jars_short=( api indexing lucene nb ui )
	jars+=( ${jars_short[@]/#/parsing-} )

	jars_short=(
		"-ant" "-ant-ui" api api-nb "-indexingbridge" "-libraries"
		"-libraries-ui" "-spi-intern" "-spi-intern-impl" ui uiapi
		uiapi-base ui-buildmenu
	)
	jars+=( ${jars_short[@]/#/project} )

	jars_short=( api )
	jars+=( ${jars_short[@]/#/refactoring-} )

	jars_short=( "" "-apimodule" )
	jars+=( ${jars_short[@]/#/spellchecker} )

	jars_short=(
		actions editor-hints navigator palette quicksearch tasklist
	)
	jars+=( ${jars_short[@]/#/spi-} )

	jars_short=( "" ui )
	jars+=( ${jars_short[@]/#/templates} )

	jars_short=( "" "-project" )
	jars+=( ${jars_short[@]/#/utilities} )

	jars_short=(
		"" "-core" "-masterfs" "-system-cvss-installer" "-util" "-ui"
	)
	jars+=( ${jars_short[@]/#/versioning} )

	jars_short=( browser-api common common-ui indent )
	jars+=( ${jars_short[@]/#/web-} )

	jars_short=(
		"" "-axi" "-catalog" "-catalog-ui" "-core" "-lexer" "-multiview"
		"-retriever" "-schema-model" "-schema-completion" "-tax"
		"-text" "-tools" "-tools-java" "-xam" "-xdm"
	)
	jars+=( ${jars_short[@]/#/xml} )

	jars+=(
		classfile diff editor favorites git ide ide-kit javahelp
		jumpto keyring lexer lexer-nbbridge localhistory localtasks
		mylyn-util progress-ui properties properties-syntax queries
		sampler sendopts settings team-commons team-ide terminal
		terminal-nb uihandler updatecenters xsl
	)
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]} # use lib vs modules for now

#	local j
#	for j in "${jars[@]}"; do
#		java-netbeans_create-module-xml "${j}" lib
#	done

	# install icon
	icon="${my_pn}.png"
	icon_dir=/usr/share/icons/hicolor/128x128/apps
	dodir ${icon_dir}
	insinto ${icon_dir}
	newins ide.branding/release/${PN}.png ${icon}
	dosym ../../..${icon_dir}/${icon} /usr/share/pixmaps/${icon}

	make_desktop_entry ${my_pn} "Netbeans ${SLOT}" ${my_pn} Development
}
