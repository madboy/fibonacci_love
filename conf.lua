function love.conf(t)
	t.window = t.window or t.screen

	t.title = "Fibonacci"
	t.window.width = 1024
	t.window.height = 768

	t.console = true

	t.screen = t.screen or t.window
end