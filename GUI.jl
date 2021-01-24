#*******************************************
# Pakiety matematyczne
# Project: Maze runner
# Roman Furman
# Visualization in GUI
#*******************************************

include("./generator.jl")
include("./solver.jl")
using .Maze_generator, .Maze_solver
using Images
using Gtk, ImageView, TestImages
#*********************
# Create window
#*********************
win = GtkWindow("Maze Generator",600,600)
#*********************
# Create general box
#*********************
general_box = GtkBox(:v)
#*********************
# Create box with labels and Comboboxes
#*********************
leb_com_box = GtkBox(:v)

tittle = GtkLabel("Maze Generator")
GAccessor.markup(tittle, """<b>Maze Generator</b>""")
push!(leb_com_box,tittle)

label_h = GtkLabel("Heigh:")
push!(leb_com_box,label_h)

height = GtkComboBoxText()
choices = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
for choice in choices
  push!(height,choice)
end
set_gtk_property!(height, :active, 4)
push!(leb_com_box, height)

label_w = GtkLabel("Width:")
push!(leb_com_box, label_w)

width = GtkComboBoxText()
choices2 = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
for choice in choices2
  push!(width, choice)
end
set_gtk_property!(width, :active, 4)
push!(leb_com_box, width)

#*********************
# Create box with bottoms
#*********************
button_box = GtkBox(:h)

b_generate = GtkButton("Generate")
push!(button_box, b_generate)

function buttom_generate(w) 
  """Function for a button that shows the generated maze image.
  """
  maze_image(parse(Int64, Gtk.bytestring(GAccessor.active_text(height))), parse(Int64, Gtk.bytestring(GAccessor.active_text(width))))
  image = load("Maze.png")
  imshow(c, image)
  print("Maze created")
end

signal_connect(buttom_generate, b_generate, :clicked)


b_solve = GtkButton("Solve")
push!(button_box, b_solve)

function buttom_solve(w)
  """Function for a button that shows the solved maze image.
  """
  maze = load("Maze.png")
  solve_image(maze)
  image = load("Solve.png")
  imshow(c, image)
  print("Maze solved")
end

signal_connect(buttom_solve, b_solve, :clicked)

b_close = GtkButton("Close")
push!(button_box, b_close)

signal_connect(b_close, :clicked) do widget
  Gtk.destroy(win)
  println("Exit")
end

set_gtk_property!(button_box, :spacing, 200)

#*********************
# Push all boxes to the window
#*********************
push!(general_box, leb_com_box)
push!(general_box, button_box)

frame, c = ImageView.frame_canvas(:auto)
push!(general_box, frame)

push!(win, general_box)
showall(win)