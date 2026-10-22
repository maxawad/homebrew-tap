cask "imake" do
  version "1.1.9,100271"
  sha256 "26aa5b7a38f1d91c53478c64577e67ecb9dcb3b8594bedaffe564fe62331c806"

  url "https://downloads.imake.lol/releases/#{version.csv.first}.#{version.csv.second}/iMake-macOS.dmg",
      verified: "downloads.imake.lol/"
  name "iMake"
  desc "Agent that turns prompts into apps, sites, and workflows on your own machines"
  homepage "https://imake.lol/"

  livecheck do
    url "https://downloads.imake.lol/releases/latest/macos.json"
    strategy :json do |json|
      "#{json["version"]},#{json["build"]}"
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "iMake.app"

  uninstall quit:      "com.maxawad.imake.mac",
            launchctl: [
              "com.devcluster.cli-server",
              "com.devcluster.quick-tunnel",
            ]

  zap trash: [
    "~/.devcluster",
    "~/Library/Caches/com.maxawad.imake.mac",
    "~/Library/HTTPStorages/com.maxawad.imake.mac",
    "~/Library/LaunchAgents/com.devcluster.cli-server.plist",
    "~/Library/LaunchAgents/com.devcluster.quick-tunnel.plist",
    "~/Library/Logs/iMake",
    "~/Library/Preferences/com.maxawad.imake.mac.plist",
    "~/Library/Saved Application State/com.maxawad.imake.mac.savedState",
  ]
end
