#' Visualizes cue accuracies in a ROC space
#'
#' @param x An FFT object
#' @param which.data A string indicating whether or not to show training ("train") or testing ("test") cue accuracies
#' @param top An integer indicating how many of the top cues to highlight
#' @param palette An optional vector of colors
#' @importFrom graphics text points abline legend mtext segments rect arrows axis par layout plot
#' @export
#'

showcues <- function(x = NULL,
                          which.data = "train",
                          top = 5,
                          palette = c("#0C5BB07F", "#EE00117F", "#15983D7F", "#EC579A7F",
                                      "#FA6B097F", "#149BED7F", "#A1C7207F", "#FEC10B7F", "#16A08C7F",
                                      "#9A703E7F")) {


cue.df <- x$cue.accuracies

stat.names <- c("hi", "mi", "fa", "cr", "hr", "far", "v", "dprime")

if(which.data == "train") {

  cue.df <- cue.df[,c("cue.name", "cue.class", "level.threshold", "level.sigdirection", paste(stat.names, ".train", sep = ""))]
  names(cue.df)[names(cue.df) %in% paste(stat.names, ".train", sep = "")] <- stat.names

}

if(which.data == "test") {

  cue.df <- cue.df[,c("cue.name", "cue.class", "level.threshold", "level.sigdirection", paste(stat.names, ".test", sep = ""))]
  names(cue.df)[names(cue.df) %in% paste(stat.names, ".test", sep = "")] <- stat.names
}

rownames(cue.df) <- 1:nrow(cue.df)

# GENERAL PLOTTING SPACE

plot(1, xlim = c(0, 1), ylim  = c(0, 1), type = "n",
     xlab = "FAR", ylab = "HR", main = "Marginal cue performance"
)

if(which.data == "test") {mtext("Testing", 3, line = .5)}
if(which.data == "train") {mtext("Training", 3, line = .5)}


rect(-100, -100, 100, 100, col = gray(.96))
abline(h = seq(0, 1, .1), lwd = c(2, 1), col = "white")
abline(v = seq(0, 1, .1), lwd = c(2, 1), col = "white")
abline(a = 0, b = 1)

# Non-top cues

cues.nontop <- subset(cue.df, rank(-v) > top)

with(cues.nontop, points(far, hr, cex = 1))

with(cues.nontop,
       text(far, hr, labels = row.names(cues.nontop),
            pos = 3, cex = .8))

# Top x cues

cues.top <- subset(cue.df, subset = rank(-v) <= top)
cues.top <- cues.top[order(cues.top$v),]

with(cues.top,
     points(far, hr, pch = 21, bg = palette, col = "white", cex = 2, lwd = 2))

with(cues.top,
     text(far, hr, labels = row.names(cues.top), pos = 3))


# Bottom right label

rect(.5, -.2, 1.02, .47,
     col = transparent("white", trans.val = .1),
     border = NA)

# Top Points
with(cues.top,
     points(rep(.52, top), seq(0, .4, length.out = top),
            pch = 21,
            bg = palette,
            col = "white", cex = 1.5)
     )

add.text <- function(labels, x, y.min, y.max, cex = .7, adj = 1) {

  text(rep(x, top),
       seq(y.min, y.max, length.out = top),
       labels,
       cex = cex,
       adj = adj
  )

}

add.text(row.names(cues.top), .54, 0, .4, adj = 0, cex = 1)
add.text(substr(cues.top$cue.name, 1, 10), .6, 0, .4, cex = .8, adj = 0)
add.text(paste(cues.top$level.sigdirection, cues.top$level.threshold), .68, 0, .4, cex = .8, adj = 0)

add.text(round(cues.top$v, 2), .85, 0, .4, cex = 1)
add.text(round(cues.top$hr, 2), .92, 0, .4, cex = 1)
add.text(round(cues.top$far, 2), .99, 0, .4, cex = 1)

text(.66, .44, "cue", adj = 0)
text(.85, .44, "v", adj = 1)
text(.92, .44, "HR", adj = 1)
text(.99, .44, "FAR", adj = 1)


# connection lines
#
# segments(x0 = cues.top$far,
#          y0 = cues.top$hr,
#          x1 = rep(.62, top),
#          y1 = seq(0, .4, length.out = top),
#          col = gray(.9)
# )

}