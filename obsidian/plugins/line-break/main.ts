import { Editor, Plugin } from 'obsidian';

// Remember to rename these classes and interfaces!


export default class MyPlugin extends Plugin {
	async onload() {
		this.addCommand({
			id: 'peaceful-break',
			name: 'Peaceful Linebreak',
			editorCallback: (editor: Editor) => {
				const editor_position = editor.getCursor();
				editor.setCursor(editor_position.line+1, 0);
				editor.replaceSelection("\n");
				editor.setCursor(editor_position.line+1, 0);
			}
		});
	}

	onunload() {

	}
}
