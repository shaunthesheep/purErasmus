$ ->
    # Make sure we need to create an editor on this page.
    page_editor = $("#page-editor")
    return if page_editor.length == 0

    # Create the editor, and configure it.
    editor = ace.edit "page-editor"
    editor.setTheme "ace/theme/monokai"
    editor.setShowPrintMargin false
    
    edit_session = editor.getSession()
    edit_session.setMode "ace/mode/markdown"
    edit_session.setUseWrapMode true

    # Textarea behavior.
    textarea = $(".page-input")

    # Set the original value of the editor.
    edit_session.setValue textarea.val()

    # Add an event to update the textarea when the form is submitted.
    textarea.parents("form").submit ->
        textarea.val edit_session.getValue()