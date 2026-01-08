export const NotificationPlugin = async ({ $, directory }) => {
  const sessionName = process.env.ZELLIJ_SESSION_NAME || "N/A"

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`osascript -e 'display notification "Done in: ${directory} | Session: ${sessionName}" with title "OpenCode"'`
      }
    },
  }
}
