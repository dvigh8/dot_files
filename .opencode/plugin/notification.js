export const NotificationPlugin = async ({ $, directory }) => {
  const getTmuxSessionTab = async () => {
    if (!process.env.TMUX_PANE) {
      return "N/A"
    }

    const sessionTab = await $`tmux display-message -p -t ${process.env.TMUX_PANE} '#S:#I'`
      .nothrow()
      .text()

    return sessionTab.trim() || "N/A"
  }

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        const sessionTab = await getTmuxSessionTab()
        await $`osascript -e 'display notification "Done in: ${directory} | Tmux: ${sessionTab}" with title "OpenCode"'`
      }
    },
  }
}
