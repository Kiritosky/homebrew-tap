cask "brainmatter" do
  version "1.1.0"
  sha256 "3601f0b07b2a0d1dfb25cd2bd441ca439c7218f9d4558db1f39760f884ea8e2b"

  url "https://github.com/Kiritosky/brainmatter/releases/download/v#{version}/Brainmatter_#{version}_aarch64.dmg"
  name "Brainmatter"
  desc "Local, encrypted knowledge graph and shared memory for AI tools"
  homepage "https://github.com/Kiritosky/brainmatter"

  # The tag comes before the build, so wait for the release.
  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Brainmatter.app"

  uninstall quit: "app.brainmatter"

  # Leaves ~/Library/Application Support/app.brainmatter alone on purpose:
  # it holds the vault, its backups and the settings.
  zap trash: [
    "~/Library/Caches/app.brainmatter",
    "~/Library/Preferences/app.brainmatter.plist",
  ]

  caveats <<~EOS
    Brainmatter is not notarized, so macOS refuses to open it the first time.
    Go to System Settings → Privacy & Security and choose Open Anyway.
  EOS
end
