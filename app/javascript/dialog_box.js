document.addEventListener("turbo:load", () => {
  const openDialogButtons = document.querySelectorAll("[data-dialog-toggle]");
  const closeDialogButtons = document.querySelectorAll(
    '[data-action^="click->close-dialog-"]'
  );

  openDialogButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      const dialogId = event.currentTarget.getAttribute("data-dialog-toggle");
      const dialog = document.querySelector(`[data-dialog="${dialogId}"]`);
      dialog.classList.remove("hidden");

      // Add event listener to close dialog on outside click
      document.addEventListener(
        "click",
        (e) => closeDialogOnOutsideClick(e, dialog),
        true
      );
    });
  });

  closeDialogButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      const action = event.currentTarget.getAttribute("data-action");
      const dialogId = action.split("->close-dialog-")[1];
      const dialog = document.querySelector(`[data-dialog="${dialogId}"]`);
      closeDialog(dialog);
    });
  });

  function closeDialogOnOutsideClick(event, dialog) {
    const dialogContent = dialog.querySelector(".dialog-box-content"); // Adjust selector to target the dialog content
    if (!dialogContent.contains(event.target)) {
      closeDialog(dialog);
      // Remove event listener after closing the dialog
      document.removeEventListener(
        "click",
        (e) => closeDialogOnOutsideClick(e, dialog),
        true
      );
    }
  }

  function closeDialog(dialog) {
    dialog.classList.add("hidden");
  }
});
