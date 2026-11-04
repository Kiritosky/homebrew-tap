cask "brainmatter" do
  version "1.2.0"
  sha256 "2f772f4b26ef236e827c23728e1386fda16cb0e8a39907c66e03b81c766800db"

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
