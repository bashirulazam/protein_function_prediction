function [precision,recall,F1] = Calc_F1(yval,yHaT)

tp = sum((yHaT == 1) & (yval == 1));
fp = sum((yHaT == 1) & (yval == 0));
fn = sum((yHaT == 0) & (yval == 1));

precision = tp / (tp + fp);
recall = tp / (tp + fn);
F1 = (2 * precision * recall) / (precision + recall);