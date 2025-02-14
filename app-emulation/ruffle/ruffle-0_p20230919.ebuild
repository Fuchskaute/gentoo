# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.21
	ab_glyph_rasterizer@0.1.8
	addr2line@0.21.0
	adler32@1.2.0
	adler@1.0.2
	ahash@0.7.6
	ahash@0.8.3
	aho-corasick@1.0.4
	aliasable@0.1.3
	allocator-api2@0.2.16
	alsa-sys@0.3.1
	alsa@0.7.1
	android-activity@0.4.3
	android-properties@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.5.0
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anstyle@1.0.2
	anyhow@1.0.75
	approx@0.5.1
	arboard@3.2.1
	arc-swap@1.6.0
	arrayref@0.3.7
	arrayvec@0.7.4
	ash@0.37.3+1.3.251
	async-channel@1.9.0
	async-io@1.13.0
	async-lock@2.8.0
	async-net@1.7.0
	async-task@4.4.0
	atk-sys@0.18.0
	atomic-waker@1.1.1
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.4
	bindgen@0.64.0
	bitflags@1.3.2
	bitflags@2.4.0
	bitstream-io@1.7.0
	bit-set@0.5.3
	bit-vec@0.6.3
	block2@0.2.0-alpha.6
	blocking@1.3.1
	block-buffer@0.10.4
	block-sys@0.1.0-beta.1
	block@0.1.6
	bstr@1.6.0
	bumpalo@3.13.0
	bytemuck@1.14.0
	bytemuck_derive@1.4.1
	byteorder@1.4.3
	bytes@1.4.0
	cairo-sys-rs@0.18.2
	calloop@0.10.6
	castaway@0.1.2
	cc@1.0.83
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-expr@0.15.4
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	chrono@0.4.26
	clang-sys@1.6.1
	clap@4.4.3
	clap_builder@4.4.2
	clap_derive@4.4.2
	clap_lex@0.5.1
	clipboard-win@4.5.0
	codespan-reporting@0.11.1
	colorchoice@1.0.0
	colored@2.0.4
	color_quant@1.1.0
	combine@4.6.6
	com-rs@0.2.1
	concurrent-queue@2.2.0
	console@0.15.7
	console_error_panic_hook@0.1.7
	convert_case@0.6.0
	cookie-factory@0.3.2
	core2@0.4.0
	coreaudio-rs@0.11.2
	coreaudio-sys@0.2.12
	core-foundation-sys@0.6.2
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	core-graphics-types@0.1.2
	core-graphics@0.22.3
	cpal@0.15.2
	cpufeatures@0.2.9
	crc32fast@1.3.2
	crc-catalog@2.2.0
	crc@3.0.1
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	csv-core@0.1.10
	csv@1.2.2
	curl-sys@0.4.65+curl-8.2.1
	curl@0.4.44
	d3d12@0.7.0
	darling@0.20.3
	darling_core@0.20.3
	darling_macro@0.20.3
	dary_heap@0.3.6
	dasp_sample@0.11.0
	data-encoding@2.4.0
	deranged@0.3.8
	diff@0.1.13
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	dispatch@0.2.0
	displaydoc@0.2.4
	dlib@0.5.2
	doc-comment@0.3.3
	downcast-rs@1.2.0
	either@1.9.0
	embed-resource@2.2.0
	encode_unicode@0.3.6
	encoding_rs@0.8.33
	enumset@1.1.2
	enumset_derive@0.8.1
	enum-map-derive@0.14.0
	enum-map@2.6.3
	env_logger@0.10.0
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.2
	error-code@2.3.1
	euclid@0.22.9
	event-listener@2.5.3
	fastrand@1.9.0
	fdeflate@0.3.0
	flate2@1.0.27
	float-cmp@0.9.0
	float_next_after@0.1.5
	fluent-bundle@0.15.2
	fluent-langneg@0.13.0
	fluent-syntax@0.11.0
	fluent-templates@0.8.0
	fluent-template-macros@0.8.0
	fluent@0.16.0
	flume@0.10.14
	fnv@1.0.7
	fontdb@0.14.1
	foreign-types-macros@0.2.3
	foreign-types-shared@0.1.1
	foreign-types-shared@0.3.1
	foreign-types@0.3.2
	foreign-types@0.5.0
	form_urlencoded@1.2.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	futures@0.3.28
	gdk-pixbuf-sys@0.18.0
	gdk-sys@0.18.0
	generational-arena@0.2.9
	generator@0.7.5
	generic-array@0.14.7
	gethostname@0.2.3
	getrandom@0.2.10
	gif@0.12.0
	gimli@0.28.0
	gio-sys@0.18.1
	glib-sys@0.18.1
	globset@0.4.13
	glob@0.3.1
	glow@0.12.3
	gobject-sys@0.18.0
	gpu-allocator@0.22.0
	gpu-alloc-types@0.3.0
	gpu-alloc@0.6.0
	gpu-descriptor-types@0.1.1
	gpu-descriptor@0.2.3
	gtk-sys@0.18.0
	hashbrown@0.12.3
	hashbrown@0.13.2
	hashbrown@0.14.0
	hassle-rs@0.10.0
	heck@0.4.1
	hermit-abi@0.3.2
	hexf-parse@0.2.1
	home@0.5.5
	http@0.2.9
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.57
	ident_case@1.0.1
	idna@0.4.0
	ignore@0.4.20
	image@0.24.7
	indexmap@1.9.3
	indexmap@2.0.0
	indicatif@0.17.6
	instant@0.1.12
	insta@1.31.0
	intl-memoizer@0.5.1
	intl_pluralrules@7.0.2
	io-lifetimes@1.0.11
	isahc@1.7.2
	is-terminal@0.4.9
	itertools@0.11.0
	itoa@1.0.9
	jni-sys@0.3.0
	jni@0.19.0
	jni@0.20.0
	jni@0.21.1
	jobserver@0.1.26
	jpeg-decoder@0.3.0
	js-sys@0.3.64
	khronos-egl@4.1.0
	lazycell@1.3.0
	lazy_static@1.4.0
	libc@0.2.147
	libflate@2.0.0
	libflate_lz77@2.0.0
	libloading@0.7.4
	libloading@0.8.0
	libm@0.2.7
	libnghttp2-sys@0.1.8+1.55.1
	libtest-mimic@0.6.1
	libz-sys@1.1.12
	linked-hash-map@0.5.6
	linkme-impl@0.3.15
	linkme@0.3.15
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.5
	lock_api@0.4.10
	log@0.4.20
	loom@0.5.6
	lru@0.11.1
	lyon@1.0.1
	lyon_algorithms@1.0.3
	lyon_geom@1.0.4
	lyon_path@1.0.4
	lyon_tessellation@1.0.10
	lzma-rs@0.3.0
	mach2@0.4.1
	malloc_buf@0.0.6
	matchers@0.1.0
	memchr@2.6.3
	memmap2@0.5.10
	memmap2@0.6.2
	memoffset@0.6.5
	memoffset@0.9.0
	metal@0.26.0
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.8
	naga@0.13.0
	naga_oil@0.9.0
	ndk-context@0.1.1
	ndk-sys@0.4.1+23.1.7779620
	ndk@0.7.0
	nix@0.24.3
	nix@0.25.1
	nohash-hasher@0.2.0
	nom@7.1.3
	number_prefix@0.4.0
	num-bigint@0.4.4
	num-complex@0.4.4
	num-derive@0.3.3
	num-derive@0.4.0
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.16
	num_cpus@1.16.0
	num_enum@0.5.11
	num_enum@0.6.1
	num_enum_derive@0.5.11
	num_enum_derive@0.6.1
	num_threads@0.1.6
	nu-ansi-term@0.46.0
	objc2-encode@2.0.0-pre.2
	objc2@0.3.0-beta.3.patch-leaks.3
	objc-foundation@0.1.1
	objc-sys@0.2.0-beta.2
	objc@0.2.7
	objc_exception@0.1.2
	objc_id@0.1.1
	object@0.32.0
	oboe-sys@0.5.0
	oboe@0.5.0
	once_cell@1.18.0
	openssl-probe@0.1.5
	openssl-sys@0.9.91
	option-ext@0.2.0
	orbclient@0.3.46
	os_info@3.7.0
	ouroboros@0.18.0
	ouroboros_macro@0.18.0
	overload@0.1.1
	owned_ttf_parser@0.19.0
	pango-sys@0.18.0
	parking@2.1.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	paste@1.0.14
	path-slash@0.2.1
	peeking_take_while@0.1.2
	percent-encoding@2.3.0
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-project@1.1.3
	pin-utils@0.1.0
	pkg-config@0.3.27
	png@0.17.10
	polling@2.8.0
	portable-atomic@1.4.3
	ppv-lite86@0.2.17
	pp-rs@0.2.1
	pretty_assertions@1.4.0
	primal-check@0.3.3
	proc-macro2@1.0.67
	proc-macro-crate@1.3.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro-hack@0.5.20+deprecated
	profiling-procmacros@1.0.9
	profiling@1.0.9
	quick-xml@0.30.0
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	range-alloc@0.1.3
	raw-window-handle@0.5.2
	rayon-core@1.11.0
	rayon@1.7.0
	realfft@3.3.0
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.1.10
	regex-automata@0.3.8
	regex-syntax@0.6.29
	regex-syntax@0.7.5
	regex@1.9.5
	regress@0.7.1
	renderdoc-sys@1.0.0
	renderdoc@0.11.0
	rfd@0.12.0
	rle-decode-fast@1.0.3
	ron@0.8.1
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustdct@0.7.1
	rustfft@6.1.0
	rustix@0.37.23
	rustix@0.38.9
	rustversion@1.0.14
	ryu@1.0.15
	safe_arch@0.7.1
	same-file@1.0.6
	schannel@0.1.22
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sctk-adwaita@0.5.4
	self_cell@0.10.2
	semver@1.0.18
	serde-wasm-bindgen@0.6.0
	serde-xml-rs@0.6.0
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.107
	serde_spanned@0.6.3
	sha2@0.10.7
	sharded-slab@0.1.4
	shlex@1.1.0
	simd-adler32@0.3.7
	similar@2.2.1
	simple_asn1@0.6.2
	slab@0.4.9
	slotmap@1.0.6
	sluice@0.5.5
	smallvec@1.11.0
	smithay-client-toolkit@0.16.0
	smithay-clipboard@0.6.6
	snafu-derive@0.7.5
	snafu@0.7.5
	socket2@0.4.9
	spin@0.9.8
	spirv@0.2.0+1.5.4
	sptr@0.3.2
	static_assertions@1.1.0
	strength_reduce@0.2.4
	strict-num@0.1.1
	strsim@0.10.0
	str-buf@1.0.6
	symphonia-bundle-mp3@0.5.3
	symphonia-core@0.5.3
	symphonia-metadata@0.5.3
	symphonia@0.5.3
	synstructure@0.13.0
	syn@1.0.109
	syn@2.0.36
	system-deps@6.1.1
	sys-locale@0.3.1
	target-lexicon@0.12.11
	termcolor@1.2.0
	thiserror-impl@1.0.47
	thiserror@1.0.47
	threadpool@1.8.1
	thread_local@1.1.7
	tiff@0.9.0
	time-core@0.1.1
	time-macros@0.2.13
	time@0.3.27
	tinystr@0.7.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tiny-skia-path@0.8.4
	tiny-skia@0.8.4
	toml@0.7.6
	toml@0.8.0
	toml_datetime@0.6.3
	toml_edit@0.19.14
	toml_edit@0.20.0
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	tracing-futures@0.2.5
	tracing-log@0.1.3
	tracing-subscriber@0.3.17
	tracing-tracy@0.10.2
	tracing-wasm@0.2.1
	tracing@0.1.37
	tracy-client-sys@0.21.1
	tracy-client@0.15.2
	transpose@0.2.2
	ttf-parser@0.19.1
	typed-arena@2.0.2
	typenum@1.16.0
	type-map@0.4.0
	type-map@0.5.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.10
	unicode-xid@0.2.4
	unic-langid-impl@0.9.1
	unic-langid-macros-impl@0.9.1
	unic-langid-macros@0.9.1
	unic-langid@0.9.1
	url@2.4.1
	utf8parse@0.2.1
	valuable@0.1.0
	vcpkg@0.2.15
	vec_map@0.8.2
	vergen@8.2.5
	version-compare@0.1.1
	version_check@0.9.4
	vswhom-sys@0.1.2
	vswhom@0.1.0
	waker-fn@1.1.0
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	wayland-client@0.29.5
	wayland-commons@0.29.5
	wayland-cursor@0.29.5
	wayland-protocols@0.29.5
	wayland-scanner@0.29.5
	wayland-sys@0.29.5
	weak-table@0.3.2
	webbrowser@0.8.11
	web-sys@0.3.64
	weezl@0.1.7
	wgpu-core@0.17.0
	wgpu-hal@0.17.0
	wgpu-types@0.17.0
	wgpu@0.17.0
	widestring@1.0.2
	wide@0.7.11
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows@0.44.0
	windows@0.46.0
	windows@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	winit@0.28.6
	winnow@0.5.15
	winreg@0.11.0
	wio@0.2.2
	x11rb-protocol@0.10.0
	x11rb@0.10.1
	x11-dl@2.21.0
	xcursor@0.3.4
	xml-rs@0.8.16
	yaml-rust@0.4.5
	yansi@0.5.1
"
declare -A GIT_CRATES=(
	[dasp]="https://github.com/RustAudio/dasp;f05a703d247bb504d7e812b51e95f3765d9c5e94;dasp-%commit%/dasp"
	[egui-wgpu]="https://github.com/emilk/egui;98087029e020a1b2d78a4eb840d0a8505340ecad;egui-%commit%/crates/egui-wgpu"
	[egui-winit]="https://github.com/emilk/egui;98087029e020a1b2d78a4eb840d0a8505340ecad;egui-%commit%/crates/egui-winit"
	[egui]="https://github.com/emilk/egui;98087029e020a1b2d78a4eb840d0a8505340ecad;egui-%commit%/crates/egui"
	[egui_extras]="https://github.com/emilk/egui;98087029e020a1b2d78a4eb840d0a8505340ecad;egui-%commit%/crates/egui_extras"
	[flash-lso]="https://github.com/ruffle-rs/rust-flash-lso;3669a352c14192d0d301e594ae6047ae99725006;rust-flash-lso-%commit%/flash-lso"
	[gc-arena]="https://github.com/kyren/gc-arena;efd89fc683c6bb456af3e226c33763cb822645e9;gc-arena-%commit%/src/gc-arena"
	[h263-rs-deblock]='https://github.com/ruffle-rs/h263-rs;16700664e2b3334f0a930f99af86011aebee14cc;h263-rs-%commit%/deblock'
	[h263-rs-yuv]="https://github.com/ruffle-rs/h263-rs;16700664e2b3334f0a930f99af86011aebee14cc;h263-rs-%commit%/yuv"
	[h263-rs]="https://github.com/ruffle-rs/h263-rs;16700664e2b3334f0a930f99af86011aebee14cc;h263-rs-%commit%/h263"
	[nellymoser-rs]="https://github.com/ruffle-rs/nellymoser;4a33521c29a918950df8ae9fe07e527ac65553f5;nellymoser-%commit%"
	[nihav_codec_support]="https://github.com/ruffle-rs/nihav-vp6;83c7e1094d603d9fc1212d39d99abb17f3a3226b;nihav-vp6-%commit%/nihav-codec-support"
	[nihav_core]="https://github.com/ruffle-rs/nihav-vp6;83c7e1094d603d9fc1212d39d99abb17f3a3226b;nihav-vp6-%commit%/nihav-core"
	[nihav_duck]="https://github.com/ruffle-rs/nihav-vp6;83c7e1094d603d9fc1212d39d99abb17f3a3226b;nihav-vp6-%commit%/nihav-duck"
)
inherit cargo desktop flag-o-matic xdg

MY_PV="nightly-${PV:3:4}-${PV:7:2}-${PV:9:2}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Flash Player emulator written in Rust"
HOMEPAGE="https://ruffle.rs/"
SRC_URI="
	https://github.com/ruffle-rs/ruffle/archive/refs/tags/${MY_PV}.tar.gz -> ${MY_P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${MY_P}"

LICENSE="|| ( Apache-2.0 MIT )"
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 ZLIB curl
" # crates
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# dlopen: libX* (see winit+x11-dl crates)
RDEPEND="
	dev-libs/glib:2
	dev-libs/openssl:=
	media-libs/alsa-lib
	sys-libs/zlib:=
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXrender
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	virtual/jre:*
	virtual/pkgconfig
	>=virtual/rust-1.70
"

QA_FLAGS_IGNORED="usr/bin/${PN}.*"

PATCHES=(
	"${FILESDIR}"/${PN}-0_p20230724-skip-render-tests.patch
)

src_configure() {
	filter-lto # TODO: cleanup after bug #893658

	# see .cargo/config.toml, only needed if RUSTFLAGS is set by the user
	[[ -v RUSTFLAGS ]] && RUSTFLAGS+=" --cfg=web_sys_unstable_apis"

	local workspaces=(
		ruffle_{desktop,scanner}
		exporter
		$(usev test tests)
	)
	cargo_src_configure ${workspaces[*]/#/--package=}
}

src_install() {
	dodoc README.md

	newicon web/packages/extension/assets/images/icon180.png ${PN}.png
	make_desktop_entry ${PN} ${PN^} ${PN} "AudioVideo;Player;Emulator;" \
		"MimeType=application/x-shockwave-flash;application/vnd.adobe.flash.movie;"

	# TODO: swap with /gentoo after https://github.com/gentoo/gentoo/pull/29510
	cd target/$(usex debug{,} release) || die

	newbin ${PN}_desktop ${PN}
	newbin exporter ${PN}_exporter
	dobin ${PN}_scanner
}

pkg_postinst() {
	xdg_pkg_postinst

	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog "${PN} is experimental software that is still under heavy development"
		elog "and only receiving nightly releases. Plans in Gentoo is to update"
		elog "roughly every months if no known major regressions (feel free to"
		elog "report if you feel a newer nightly is needed ahead of time)."
		elog
		elog "There is currently no plans to support wasm builds / browser"
		elog "extensions, this provides the desktop viewer and other tools."
	fi
}
