# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-netbeans.eclass
# @MAINTAINER: William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR: William L. Thomson Jr. <wlt@o-sinc.com>
# @BLURB: Netbeans IDE common code

if [[ -z ${_JAVA_NETBEANS_ECLASS} ]]; then
_JAVA_NETBEANS_ECLASS=1

MY_PN="incubator-${PN%%-*}"
MY_PV="${PV//_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD//-/.}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
	inherit git-r3
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Netbeans IDE"
HOMEPAGE="https://netbeans.org"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"
S="${WORKDIR}/${MY_S}/${MY_MOD}"

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install

# @FUNCTION: java-netbeans_src_unpack
# @DESCRIPTION:
# Only unpack whats needed
java-netbeans_src_unpack() {
	if [[ "${PN}" != "${PN%%-*}" ]]; then
		local tgz
		tgz="${MY_P}.tar.gz"
		echo ">>> Unpacking ${tgz} to ${PWD}"
		tar -xzf "${DISTDIR}/${tgz}" \
			"${MY_P}/${MY_MOD}/" -C "${WORKDIR}" \
			|| die "Failed to unpack ${DISTDIR}/${tgz}"
	else
		default
	fi
}

# @FUNCTION: java-netbeans_src_prepare
# @DESCRIPTION:
# Prepare sources
java-netbeans_src_prepare() {
	local f files

	JAVA_RES_DIR="resources"
	mkdir -p ${JAVA_RES_DIR} ||  die "Failed to make resorces dir"
	if [[ -d src/META-INF ]]; then
		mv src/META-INF ${JAVA_RES_DIR} || die "Failed to move META-INF"
	else
		mkdir -p ${JAVA_RES_DIR}/META-INF \
			|| die "Failed to make META-INF dir"
	fi

	# manifest
	if [[ -f manifest.mf ]]; then
		mv manifest.mf ${JAVA_RES_DIR}/META-INF/MANIFEST.MF \
			|| die "Failed to move manifest"
		sed -i -e '/OpenIDE-Module-Implementation-Version/d' \
			-e '2iOpenIDE-Module-Build-Version: '${PV}'-os-xtoo' \
			-e '2iOpenIDE-Module-Implementation-Version: '${PV}'-os-xtoo' \
			"${JAVA_RES_DIR}/META-INF/MANIFEST.MF" \
			|| die "Failed to append to manifest"
	fi

	# copy resources need to preserve paths? maybe delete sources?
	cp -r src/* ${JAVA_RES_DIR} || die "Failed to copy resources"
	find ${JAVA_RES_DIR} -name '*.java' -delete \
		|| die "Failed to delete sources from resources"

	# delete for re-generation of non static additions
	find src/ -name Bundle.properties -delete \
		|| die "Failed to remove Bundle.properties"

	java-utils-2_src_prepare
}

# @FUNCTION: java-netbeans_create-module-xml
# @DESCRIPTION:
# Create module xml file in config/Modules
#
# @CODE
# Parameters:
# $1: A jar name without .jar suffix
# $2: Module directory, core, lib, or modules
# $3: Set to any value to skip netbeans/org prefix
java-netbeans_create-module-xml() {
	local orig mod xml

	# set original, module, and xml file names
	orig="${1}"
	mod="${1}"
	if [[ -z ${3} ]]; then
		orig="netbeans-${1}"
		mod="${1/o-n-/}"
		mod="${mod/.options-/module.options}"
		[[ "${mod}" != openide* ]] && mod="netbeans.${mod}"
		mod="org.${mod}"
	fi
	xml="${mod//./-}.xml"

	echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE module PUBLIC "-//NetBeans//DTD Module Status 1.0//EN" "http://www.netbeans.org/dtds/module-status-1_0.dtd">
<module name="'${mod//-/.}'">
        <param name="eager">false</param>
        <param name="enabled">true</param>
        <param name="jar">'${2}'/'${orig}'.jar</param>
        <param name="reloadable">false</param>
</module>
' > "${T}/${xml}" || die "Failed to generate ${xml}"

	insinto /usr/share/netbeans-${SLOT}/config/Modules
	doins "${T}/${xml}"
}

# @FUNCTION: java-netbeans_get_processors
# @DESCRIPTION:
# Returns a list of processors for annotation processing
java-netbeans_get-processors() {
	local oim nb nbm procs

	nb="org.netbeans"
	nbm="${nb}.modules"
	oim="${nbm}.openide"
	procs="${NB_PROC}"

	if [[ "${CP_DEPEND}" == *editor-settings* ]] &&
		[[ "${CP_DEPEND}" != *netbeans-settings* ]]; then
		eerror "Missing netbeans-settings from CP_DEPEND"
		die
	fi

	if ( [[ "${CP_DEPEND}" == *api-intent* ]] ||
		[[ "${CP_DEPEND}" == *editor-lib2* ]] ||
		[[ "${CP_DEPEND}" == *editor-mimelookup* ]] ||
		[[ "${CP_DEPEND}" == *openide-awt* ]] ||
		[[ "${CP_DEPEND}" == *openide-nodes* ]] ) &&
		[[ "${CP_DEPEND}" != *openide-filesystems* ]]; then
		eerror "Missing netbeans-openide-filesystems from CP_DEPEND"
		die
	fi

	if [[ "${CP_DEPEND}" == *openide-windows* ]] &&
		[[ "${CP_DEPEND}" != *openide-nodes* ]]; then
		eerror "Missing netbeans-openide-nodes from CP_DEPEND"
		die
	fi

	if [[ "${CP_DEPEND}" == *openide-windows* ]] &&
		[[ "${CP_DEPEND}" != *openide-util-ui* ]]; then
		eerror "Missing netbeans-openide-util-ui from CP_DEPEND"
		die
	fi

	case "${CP_DEPEND}" in
		*api-annotations*)
			procs+=",${nb}.api.annotations.common.proc.StaticResourceProcessor"
			;;&
#		*"api-java-${PV}"*)
#			procs+=",${nb}.api.java.queries.AnnotationProcessingQuery"
#			;;&
		*api-intent*)
			procs+=",${nbm}.intent.OpenUriHandlerProcessor"
			;;&
		*api-templates*)
			procs+=",${nbm}.templates.TemplateProcessor"
			;;&
		*core-ide*)
			procs+=",${nb}.core.ide.ServiceTabProcessor"
			;;&
		*core-multiview*)
			procs+=",${nb}.core.multiview.MultiViewProcessor"
			;;&
		*editor-lib2*)
			procs+=",${nbm}.editor.lib2.EditorActionRegistrationProcessor"
			;;&
		*editor-mimelookup*)
			procs+=",${nbm}.editor.mimelookup.CreateRegistrationProcessor"
			;;&
		*"extexecution-${PV}"*)
			procs+=",${nbm}.extexecution.startup.StartupExtenderRegistrationProcessor"
			;;&
		*net-java-html-json*)
			procs+=",${nb}.html.json.impl.ModelProcessor"
			;;&
		*openide-awt*)
			procs+=",${oim}.awt.ActionProcessor"
			;;&
		*openide-filesystems*)
			procs+=",${oim}.filesystems.declmime.MIMEResolverProcessor"
			;;&
		*openide-loader*)
			procs+=",${oim}.loaders.DataObjectFactoryProcessor"
			;;&
		*openide-modules*)
			procs+=",${nbm}.openide.modules.PatchedPublicProcessor"
			;;&
		*openide-nodes*)
			procs+=",${oim}.nodes.NodesAnnotationProcessor"
			;;&
		*"openide-util-${PV}"*)
			procs+=",${oim}.util.NamedServiceProcessor"
			procs+=",${oim}.util.NbBundleProcessor"
			procs+=",${oim}.util.ServiceProviderProcessor"
			;;&
		*openide-windows*)
			procs+=",${oim}.windows.TopComponentProcessor"
			;;&
		*options-api*)
			procs+=",${nbm}.options.OptionsPanelControllerProcessor"
			;;&
		*openide-windows*)
			procs+=",${oim}.windows.TopComponentProcessor"
			;;&
		*parsing-api*)
			procs+=",${nbm}.parsing.impl.EmbeddingProviderRegistrationProcessor"
			;;&
		*project-ant*)
			procs+=",${nbm}.project.ant.AntBasedProcessor"
			;;&
		*projectapi*)
			procs+=",${nbm}.projectapi.LookupProviderAnnotationProcessor"
			;;&
		*"projectuiapi-${PV}"*)
			procs+=",${nbm}.project.uiapi.NodeFactoryAnnotationProcessor"
			procs+=",${nbm}.project.uiapi.CompositeCategoryProviderAnnotationProcessor"
			;;&
		*projectuiapi-base*)
			procs+=",${nbm}.project.ui.convertor.ProjectConvertorProcessor"
			;;&
		*refactoring-api*)
			procs+=",${nbm}.refactoring.spi.impl.ScopeAnnotationProcessor"
			;;&
		*sendopts*)
			procs+=",${nbm}.sendopts.OptionAnnotationProcessor"
			;;&
		*settings*)
			procs+=",${nbm}.settings.convertors.ConvertorProcessor"
			;;&
		*spi-navigator*)
			procs+=",${nbm}.navigator.NavigatorPanelRegistrationProcessor"
			;;&
		*spi-palette*)
			procs+=",${nbm}.palette.PaletteItemRegistrationProcessor"
			;;&
		*"versioning-${PV}"*)
			procs+=",${nbm}.versioning.VCSRegistrationProcessor"
			;;&
		*versioning-core*)
			procs+=",${nbm}.versioning.core.VCSRegistrationProcessor"
			;;&
		*) ;;
	esac

	procs="${procs#,}"
	procs="${procs%,}"

	echo "${procs}"
}

# @FUNCTION: java-netbeans_src_compile
# @DESCRIPTION:
# Wrapper for java-pkg-simple_src_compile to set common JAVAC_ARGS
java-netbeans_src_compile() {
	local p procs props

	JAVAC_ARGS+=" -parameters --source-path resources:src "
	[[ -z ${NB_NO_PROC} ]] &&
		procs="$(java-netbeans_get-processors)"
	if [[ -n ${procs} ]]; then
		if java-pkg_is-release-ge "9"; then
			JAVAC_ARGS+=" --add-modules java.xml.ws.annotation"
		fi

		JAVAC_ARGS+=" -processor ${procs} "

		# for resources
		JAVA_CLASSPATH_EXTRA="resources:src"

		# skip jar creation
		JAVA_NO_JAR=0
		java-pkg-simple_src_compile

		# combine generated properties with static
		props=( $(find target -name '*.properties') )
		for p in "${props[@]}"; do
			cat "${p}" >> resources/${p/target\/classes/} \
				|| die "Failed to append to Bundle.properties"
			rm "${p}" || die "Failed to remove ${p}"
		done

		java-pkg-simple_create-jar "target/classes"
	else
		java-pkg-simple_src_compile
	fi
}

# @FUNCTION: java-netbeans_src_install
# @DESCRIPTION:
# Wrapper for java-pkg-simple_src_install to install common stuff
# outside of the main jar
java-netbeans_src_install() {
	java-pkg-simple_src_install
	if [[ -f module-auto-deps.xml ]]; then
		local dir
		dir="/usr/share/${PN%%-*}-${SLOT}/config/ModuleAutoDeps/"
		insinto "${dir}"
		newins module-auto-deps.xml org-${PN}.xml
	fi
}

# fi _JAVA_NETBEANS_ECLASS
fi
