# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 llvm.org

DESCRIPTION="Common files shared between multiple slots of clang"
HOMEPAGE="https://llvm.org/"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA"
SLOT="0"
KEYWORDS=""
IUSE="
	default-compiler-rt default-libcxx default-lld llvm-libunwind
	stricter
"

PDEPEND="
	sys-devel/clang:*
	default-compiler-rt? (
		sys-devel/clang-runtime[compiler-rt]
		llvm-libunwind? ( sys-libs/llvm-libunwind )
		!llvm-libunwind? ( sys-libs/libunwind )
	)
	!default-compiler-rt? ( sys-devel/gcc )
	default-libcxx? ( >=sys-libs/libcxx-${PV} )
	!default-libcxx? ( sys-devel/gcc )
	default-lld? ( sys-devel/lld )
	!default-lld? ( sys-devel/binutils )
"
IDEPEND="
	!default-compiler-rt? ( sys-devel/gcc-config )
	!default-libcxx? ( sys-devel/gcc-config )
"

LLVM_COMPONENTS=( clang/utils )
llvm.org_set_globals

pkg_pretend() {
	[[ ${CLANG_IGNORE_DEFAULT_RUNTIMES} ]] && return

	local flag missing_flags=()
	for flag in default-{compiler-rt,libcxx,lld}; do
		if ! use "${flag}" && has_version "sys-devel/clang[${flag}]"; then
			missing_flags+=( "${flag}" )
		fi
	done

	if [[ ${missing_flags[@]} ]]; then
		eerror "It seems that you have the following flags set on sys-devel/clang:"
		eerror
		eerror "  ${missing_flags[*]}"
		eerror
		eerror "The default runtimes are now set via flags on sys-devel/clang-common."
		eerror "The build is being aborted to prevent breakage.  Please either set"
		eerror "the respective flags on this ebuild, e.g.:"
		eerror
		eerror "  sys-devel/clang-common ${missing_flags[*]}"
		eerror
		eerror "or build with CLANG_IGNORE_DEFAULT_RUNTIMES=1."
		die "Mismatched defaults detected between sys-devel/clang and sys-devel/clang-common"
	fi
}

src_install() {
	newbashcomp bash-autocomplete.sh clang

	insinto /etc/clang
	newins - gentoo-runtimes.cfg <<-EOF
		# This file is initially generated by sys-devel/clang-runtime.
		# It is used to control the default runtimes using by clang.

		--rtlib=$(usex default-compiler-rt compiler-rt libgcc)
		--unwindlib=$(usex default-compiler-rt libunwind libgcc)
		--stdlib=$(usex default-libcxx libc++ libstdc++)
		-fuse-ld=$(usex default-lld lld bfd)
	EOF

	newins - gentoo-gcc-install.cfg <<-EOF
		# This file is maintained by gcc-config.
		# It is used to specify the selected GCC installation.
	EOF

	newins - gentoo-common.cfg <<-EOF
		# This file contains flags common to clang, clang++ and clang-cpp.
		@gentoo-runtimes.cfg
		@gentoo-gcc-install.cfg
	EOF

	if use stricter; then
		newins - gentoo-stricter.cfg <<-EOF
			# This file increases the strictness of older clang versions
			# to match the newest upstream version.

			# clang-16 defaults
			-Werror=implicit-function-declaration
			-Werror=implicit-int
			-Werror=incompatible-function-pointer-types

			# constructs banned by C2x
			-Werror=deprecated-non-prototype

			# deprecated but large blast radius
			#-Werror=strict-prototypes
		EOF

		cat >> "${ED}/etc/clang/gentoo-common.cfg" <<-EOF || die
			@gentoo-stricter.cfg
		EOF
	fi

	local tool
	for tool in clang{,++,-cpp}; do
		newins - "${tool}.cfg" <<-EOF
			# This configuration file is used by ${tool} driver.
			@gentoo-common.cfg
		EOF
	done
}

pkg_preinst() {
	if has_version -b sys-devel/gcc-config && has_version sys-devel/gcc
	then
		local gcc_path=$(gcc-config --get-lib-path 2>/dev/null)
		if [[ -n ${gcc_path} ]]; then
			cat >> "${ED}/etc/clang/gentoo-gcc-install.cfg" <<-EOF
				--gcc-install-dir="${gcc_path%%:*}"
			EOF
		fi
	fi
}
