public static final int RowCells = 20;
public static final int ColCells = 20;
public int i = 0;
public boolean on = false;
public boolean cellDraw = false;
public Cell [][] cells = new Cell [RowCells][ColCells];
public Cell [][] oldCells = new Cell [RowCells][ColCells];
void setup() {
  size(800, 800);
  background(255);
  for (int r = 0; r < cells.length; r++) {
    for (int c = 0; c < cells[r].length; c++) {
      cells[r][c] = new Cell(r, c);
    }
  }
  for (int r = 0; r < cells.length; r++) {
    for (int c = 0; c < cells[r].length; c++) {
      oldCells[r][c] = new Cell(r, c);
    }
  }
  for (int r = 0; r < cells.length; r++) {
        for (int c = 0; c < cells[r].length; c++) {
          cells[r][c].show();
        }
      }
}
public void draw() {
  if (cellDraw && on == false) {
    for (int r = 0; r < cells.length; r++) {
      for (int c = 0; c < cells[r].length; c++) {
        if (cells[r][c].mouseIn()) {
          cells[r][c].setLive(true);
          cells[r][c].show();
        }
      }
    }
  }
  if (i == 0) {
    if (on) {
      background(255);
      for (int r = 0; r < cells.length; r++) {
        for (int c = 0; c < cells[r].length; c++) {
          oldCells[r][c].setLive(cells[r][c].getLive());
        }
      }
      for (int r = 0; r < cells.length; r++) {
        for (int c = 0; c < cells[r].length; c++) {
          cells[r][c].recalculate();
        }
      }
      for (int r = 0; r < cells.length; r++) {
        for (int c = 0; c < cells[r].length; c++) {
          cells[r][c].show();
        }
      }
    }
  } else if (i == 2) {
    i = -1;
  }
  i++;
}

public void mousePressed() {
  cellDraw = !cellDraw;
}
public void keyPressed() {
  on = !on;
}
public class Cell {
  private boolean alive;
  private int myColor;
  private double myX;
  private double myY;
  private int row;
  private int col;
  public Cell(int r, int c) {
     alive = false;
     row = r;
     col = c;
     myX = 800*c/ColCells;
     myY = 800*r/RowCells;
  }
  public boolean getLive() {
    return alive;
  }
  public void setLive(boolean l) {
    alive = l;
  }
  public void recalculate() {
    if (alive && countNeighborTrues(row, col, RowCells, ColCells) == 2) {
      alive = true;
    } else if (countNeighborTrues(row, col, RowCells, ColCells) == 3) {
      alive = true;
    } else {
      alive = false;
    }
  }
  public void show() {
    if (alive) {
      myColor = color(0);
    } else {
      myColor = color(200);
    }
    fill(myColor);
    rect((float) myX, (float) myY, 800/ColCells, 800/RowCells);
  }
  public boolean mouseIn() {
    return (mouseX >= myX && mouseY >= myY && mouseX <= myX+800/ColCells && mouseY <= myY + 800/RowCells);
  }
}public boolean isValidOnXbyY(int row, int col, int R, int C){
  if (row<R && row >= 0 && col >= 0 && col < C) {
    return true;
  } else {
    return false;
  }
}
public int countNeighborTrues(int row, int col, int R, int C){
  int trues = 0;
  for (int r = row - 1; r < row + 2; r++) {
    for (int c = col - 1; c < col + 2; c++) {
      if (isValidOnXbyY(r, c, R, C) == false) {
      } else {
        if (oldCells[r][c].getLive() == true && (r != row || c != col)) {
        trues++;
        }
      }
    }
  }
  return trues;
}
