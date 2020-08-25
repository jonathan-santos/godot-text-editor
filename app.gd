extends Control

func _ready():
	pass

func _on_OpenFile_pressed():
	$OpenFileDialog.popup()

func _on_SaveAsFile_pressed():
	$SaveAsFileDialog.popup()

func _on_OpenFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()

func _on_SaveAsFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
