-- Install: rustup component add rust-analyzer   (or :MasonInstall rust-analyzer)
return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	-- Nearest Cargo.toml wins over .git
	root_markers = { { "Cargo.toml" }, { ".git" } },
}
