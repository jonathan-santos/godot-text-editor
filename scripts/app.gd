extends Control

var app_name = "Text Editor"
const UNTITLED = "Untitled"
var current_file = UNTITLED

onready var file_menu_popup = $Content/MenuItems/File.get_popup()
onready var help_menu_popup = $Content/MenuItems/Help.get_popup()
onready var textedit = $Content/TextEdit

func _ready():
	file_menu_popup.connect("id_pressed", self, "_on_FileMenu_id_pressed")
	help_menu_popup.connect("id_pressed", self, "_on_HelpMenu_id_pressed")
	
	update_window_title()	
	
func update_window_title():
	OS.set_window_title(app_name + " - " + current_file)
	
func save_current_file():
	if current_file == UNTITLED:
		$SaveAsFileDialog.popup()
		return
	
	var f = File.new()
	f.open(current_file, 2)
	f.store_string(textedit.text)
	f.close()
	
func _on_FileMenu_id_pressed(id):
	match id:
		0:
			current_file = UNTITLED
			update_window_title()
			textedit.text = ""
		1:
			$OpenFileDialog.popup()
		2:
			save_current_file()
		3:
			$SaveAsFileDialog.popup()
		4:
			get_tree().quit()
		
func _on_HelpMenu_id_pressed(id):
	match id:
		0:
			$AboutWindow.popup()
		1:
			OS.shell_open("https://jhow.io")

func _on_OpenFileDialog_file_selected(path):
	current_file = path
	update_window_title()
	var f = File.new()
	f.open(path, 1)
	textedit.text = f.get_as_text()
	f.close()

func _on_SaveAsFileDialog_file_selected(path):
	current_file = path
	update_window_title()
	var f = File.new()
	f.open(path, 2)
	f.store_string(textedit.text)
	f.close()
