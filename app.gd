extends Control

onready var file_menu_popup = $FileMenu.get_popup()
onready var help_menu_popup = $HelpMenu.get_popup()

func _ready():
	file_menu_popup.connect("id_pressed", self, "_on_FileMenu_id_pressed")
	help_menu_popup.connect("id_pressed", self, "_on_HelpMenu_id_pressed")
	
func _on_FileMenu_id_pressed(id):
	if id == 0:
		$OpenFileDialog.popup()
	elif id == 1:
		$SaveAsFileDialog.popup()
	elif id == 2:
		get_tree().quit()
		
func _on_HelpMenu_id_pressed(id):
	if id == 0:
		$AboutWindow.popup()

func _on_OpenFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()
	f.close()

func _on_SaveAsFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
	f.close()
