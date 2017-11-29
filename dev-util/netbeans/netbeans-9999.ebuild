# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"

ASM_SLOT="6"
JUNIT_SLOT="4"
LUCENE_SLOT="3"
SWING_SLOT="1"

RDEPEND="
	dev-java/asm:${ASM_SLOT}
	dev-java/jsr305:0
	dev-java/junit:${JUNIT_SLOT}
	dev-java/lucene-core:${LUCENE_SLOT}
	~dev-java/${PN}-api-java-${PV}:${SLOT}
	~dev-java/${PN}-core-execution-${PV}:${SLOT}
	~dev-java/${PN}-core-ide-${PV}:${SLOT}
	~dev-java/${PN}-core-io-ui-${PV}:${SLOT}
	~dev-java/${PN}-core-multitabs-${PV}:${SLOT}
	~dev-java/${PN}-core-multiview-${PV}:${SLOT}
	~dev-java/${PN}-core-network-${PV}:${SLOT}
	~dev-java/${PN}-core-osgi-${PV}:${SLOT}
	~dev-java/${PN}-core-output2-${PV}:${SLOT}
	~dev-java/${PN}-core-ui-${PV}:${SLOT}
	~dev-java/${PN}-editor-actions-${PV}:${SLOT}
	~dev-java/${PN}-editor-bracesmatching-${PV}:${SLOT}
	~dev-java/${PN}-editor-global-format-${PV}:${SLOT}
	~dev-java/${PN}-editor-fold-nbui-${PV}:${SLOT}
	~dev-java/${PN}-editor-plain-${PV}:${SLOT}
	~dev-java/${PN}-editor-search-${PV}:${SLOT}
	~dev-java/${PN}-editor-settings-storage-${PV}:${SLOT}
	~dev-java/${PN}-extbrowser-${PV}:${SLOT}
	~dev-java/${PN}-keyring-${PV}:${SLOT}
	~dev-java/${PN}-libs-asm-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-linux-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-nio2-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-ui-${PV}:${SLOT}
	~dev-java/${PN}-o-n-upgrader-${PV}:${SLOT}
	~dev-java/${PN}-openide-execution-${PV}:${SLOT}
	~dev-java/${PN}-openide-compat-${PV}:${SLOT}
	~dev-java/${PN}-openide-options-${PV}:${SLOT}
	~dev-java/${PN}-options-keymap-${PV}:${SLOT}
	~dev-java/${PN}-parsing-nb-${PV}:${SLOT}
	~dev-java/${PN}-parsing-ui-${PV}:${SLOT}
	~dev-java/${PN}-projectapi-nb-${PV}:${SLOT}
	~dev-java/${PN}-projectui-${PV}:${SLOT}
	~dev-java/${PN}-sendopts-${PV}:${SLOT}
	~dev-java/${PN}-spi-navigator-${PV}:${SLOT}
	~dev-java/${PN}-spi-palette-${PV}:${SLOT}
	~dev-java/${PN}-templates-${PV}:${SLOT}
	~dev-java/${PN}-versioning-${PV}:${SLOT}
	dev-java/swing-layout:${SWING_SLOT}
	>=virtual/jdk-9
"
#	~dev-java/${PN}-openide-filesystem-compat8-${PV}:${SLOT}

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

src_install() {
	local icon icon_dir jars jars_short my_pn
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

	# symlinks in docs
	dosym ../../junit-${JUNIT_SLOT}/sources/junit-src.zip \
		/usr/share/${my_pn}/docs/junit-sources.jar
	dosym ../../swing-layout-${SWING_SLOT}/sources/swing-layout-src.zip \
		/usr/share/${my_pn}/docs/swing-layout-sources.jar

	# symlink jars in core
	jars=( core-startup core-startup-base libs-asm o-n-core )
	symlink_jars "/usr/share/${my_pn}/core" ${jars[@]}
	dosym ../../asm-${ASM_SLOT}/lib/asm.jar \
		/usr/share/${my_pn}/lib/asm.jar
	dosym ../../jsr305/lib/jsr305.jar \
		/usr/share/${my_pn}/lib/jsr305.jar

	# symlink jars in lib
	jars=(
		o-n-bootstrap o-n-upgrader openide-filesystems openide-modules
		openide-util openide-util-lookup openide-util-ui
	)
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]}
	dosym ../../lucene-core-${LUCENE_SLOT}/lib/lucene-core.jar \
		/usr/share/${my_pn}/lib/lucene-core.jar

	# symlink jars in modules
	jars_short=(
		annotations-common intent io progress progress-nb java templates
	)
	jars=( ${jars_short[@]/#/api-} )
	jars_short=(
		execution ide io-ui multitabs multiview network osgi
		output2 windows ui
	)
	jars+=( ${jars_short[@]/#/core-} )
	jars_short=(
		actions bracesmatching completion document errorstripe
		errorstripe-api fold fold-nbui global-format guards indent lib
		lib2 mimelookup plain plain-lib search settings settings-lib
		settings-storage util
	)
	jars+=( ${jars_short[@]/#/editor-} )
	jars_short=( browser execution execution-base )
	jars+=( ${jars_short[@]/#/ext} )
	jars_short=(
		actions awt compat dialogs execution explorer filesystems-nb
		io loaders nodes options text windows
	)
	jars+=( ${jars_short[@]/#/openide-} )
	jars_short=( outline plaf tabcontrol )
	jars+=( ${jars_short[@]/#/o-n-swing-} )
	jars_short=( linux nio2 ui )
	jars+=( ${jars_short[@]/#/masterfs-} )
	jars_short=( api editor keymap )
	jars+=( ${jars_short[@]/#/options-} )
	jars_short=( api indexing lucene nb ui )
	jars+=( ${jars_short[@]/#/parsing-} )
	jars_short=( "-indexingbridge" api api-nb uiapi uiapi-base )
	jars+=( ${jars_short[@]/#/project} )
	jars_short=( api )
	jars+=( ${jars_short[@]/#/refactoring-} )
	jars_short=( navigator palette quicksearch tasklist )
	jars+=( ${jars_short[@]/#/spi-} )
	jars+=(
		diff editor keyring lexer masterfs queries sampler sendopts
		settings templates versioning versioning-core
	)
	symlink_jars "/usr/share/${my_pn}/modules" ${jars[@]}

	insinto /usr/share/${my_pn}/config/Modules
	local f j
	for j in "${jars[@]}"; do
		f="${j/o-n-/}"
		f="${f/.options-/module.options}"
		[[ "${f}" != openide* ]] && f="${PN}.${f}"
		f="org.${f}"
		echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE module PUBLIC "-//NetBeans//DTD Module Status 1.0//EN" "http://www.netbeans.org/dtds/module-status-1_0.dtd">
<module name="'${f//-/.}'">
	<param name="eager">false</param>
	<param name="enabled">true</param>
	<param name="jar">modules/'${PN}-${j}'.jar</param>
	<param name="reloadable">false</param>
</module>
' > "${T}/${f//./-}.xml" || die "Failed to generate ${PN}-${j}.xml"
		doins "${T}/${f//./-}.xml"
	done

	# install icon
	icon="${my_pn}.png"
	icon_dir=/usr/share/icons/hicolor/128x128/apps
	dodir ${icon_dir}
	insinto ${icon_dir}
	newins ide.branding/release/${PN}.png ${icon}
	dosym ../../..${icon_dir}/${icon} /usr/share/pixmaps/${icon}

	make_desktop_entry ${my_pn} "Netbeans ${SLOT}" ${my_pn} Development
}
