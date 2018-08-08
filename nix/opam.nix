{ stdenv, pkgs, fetchFromGitHub }:
let base = {
	name = "opam-lib"; # TODO: name individually
	src = fetchFromGitHub {
		repo = "opam";
		owner = "ocaml";
		rev = "2.0.0-rc3";
		sha256 = "07zzabv8qrgqglzxm3jkb33byfjvsrimly5m1jgi6m9mdcqzp8wb";
	};
}; in

{
	core = { cppo, dune, ocamlgraph, re }: stdenv.mkDerivation (base // {
		buildInputs = [cppo dune ocamlgraph re];
		buildFlags = "core.install";
	});
	file-format = {}: stdenv.mkDerivation (base // { });
	format = { dune, opam-core, opam-file-format }: stdenv.mkDerivation (base // {
		buildInputs = [dune opam-core opam-file-format];
	});
	installer = { cmdliner, dune, opam-format }: stdenv.mkDerivation (base // {
		buildInputs = [cmdliner dune opam-format ];
	});
	solver = { cudf, dose3, dune, mccs, opam-format }: stdenv.mkDerivation (base // {
		buildInputs = [cudf dose3 dune mccs opam-format ];
	});
}
