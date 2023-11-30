extends Node

signal change_level_signal

func change_level():
	change_level_signal.emit()
