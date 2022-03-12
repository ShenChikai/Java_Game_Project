class Bar extends ImageNew {

    constructor(x, y, starting) {
        super(50*starting, 10, "images/progress.png", x, y, "image", "no flip");
        this.starting = starting;
        this.now = starting;
        this.minus = 0.01;  // each round += 0.025
    }

    lower() {
        this.starting -= this.minus;  // 0.01
        this.width -= this.minus;     // 0.01
        this.now = this.width;
    }

    raise() {
        this.starting += 0.5;   // 0.05
        this.width += 0.5;      // 0.05
        this.now = this.width;
    }

    addDifficulty(minusVal) {
        this.minus = minusVal;
    }
}