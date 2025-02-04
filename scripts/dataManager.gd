extends Node

var data

func createData():
	var file = FileAccess.open("user://data.json", FileAccess.WRITE)
	var content = { "HighScore" : 0 }
	file.store_line(JSON.stringify(content))
	file.close()

func loadData():
	if !FileAccess.file_exists("user://data.json"):
		await createData()
		loadData()
	else:
		var file = FileAccess.open("user://data.json", FileAccess.READ)
		data = JSON.parse_string(file.get_as_text())
		file.close()

func saveData():
	var file = FileAccess.open("user://data.json", FileAccess.WRITE)
	var saved = JSON.stringify(data)
	file.store_line(saved)
	file.close()
	loadData()
