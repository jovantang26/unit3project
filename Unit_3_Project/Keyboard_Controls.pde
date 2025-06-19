void keyPressed() {
  if (key == 'W' | key == 'w') wKey = true;
  if (key == 'A' | key == 'a') aKey = true;
  if (key == 'S' | key == 's') sKey = true;
  if (key == 'D' | key == 'd') dKey = true;
  if (key == ' ') spaceKey = true;
  if (keyCode == SHIFT) shiftKey = true;
}

void keyReleased() {
  if (key == 'W' | key == 'w') wKey = false;
  if (key == 'A' | key == 'a') aKey = false;
  if (key == 'S' | key == 's') sKey = false;
  if (key == 'D' | key == 'd') dKey = false;
  if (key == ' ') spaceKey = false;
  if (keyCode == SHIFT) shiftKey = false;
}
