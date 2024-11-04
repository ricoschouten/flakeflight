def start_zellij [] {
  if "ZELLIJ" not-in ($env | columns) {
    if "ZELLIJ_AUTO_START" in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == "true" {
      zellij attach -c
    } else {
      zellij
    }

    if "ZELLIJ_AUTO_EXIT" in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == "true" {
      exit
    }
  }
}
 
