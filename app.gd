extends Control

var app_name = "Text Editor"
var current_file = "Untitled"

onready var file_menu_popup = $FileMenu.get_popup()
onready var help_menu_popup = $HelpMenu.get_popup()

func _ready():
	file_menu_popup.connect("id_pressed", self, "_on_FileMenu_id_pressed")
	help_menu_popup.connect("id_pressed", self, "_on_HelpMenu_id_pressed")
	
	update_window_title()	
	
func update_window_title():
	OS.set_window_title(app_name + " - " + current_file)
	
func save_current_file():
	if current_file == "Untitled":
		$SaveAsFileDialog.popup()
		return
	
	var f = File.new()
	f.open(current_file, 2)
	f.store_string($TextEdit.text)
	f.close()
	
func _on_FileMenu_id_pressed(id):
	if id == 0:
		current_file = "Untitled"
		update_window_title()
		$TextEdit.text = ""
	elif id == 1:
		$OpenFileDialog.popup()
	elif id == 2:
		save_current_file()
	elif id == 3:
		$SaveAsFileDialog.popup()
	elif id == 4:
		get_tree().quit()
		
func _on_HelpMenu_id_pressed(id):
	if id == 0:
		$AboutWindow.popup()
	elif id == 1:
		OS.shell_open("https://jhow.io")

func _on_OpenFileDialog_file_selected(path):
	current_file = path
	update_window_title()
	var f = File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()
	f.close()

func _on_SaveAsFileDialog_file_selected(path):
	current_file = path
	update_window_title()
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
	f.close()
