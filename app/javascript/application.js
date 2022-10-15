// Entry point for the build script in your package.json

import "./react"

document.addEventListener("DOMContentLoaded", () => {
  flashNotificationArea = document.getElementById("flash_notification_area")
  if (flashNotificationArea) {
    setTimeout(() => {
      flashNotificationArea.style.top = "-50px"
    }, 2500)
  }
})
