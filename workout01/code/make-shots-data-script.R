curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
klay <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)

klay$name = "Klay Thompson"
green$name = "Draymond Green"
durant$name = "Kevin Durant"
curry$name = "Stephen Curry"
iguodala$name = "Andre Iguodala"

curry$shot_made_flag[curry$shot_made_flag == 'n'] = 'shot_no'
curry$shot_made_flag[curry$shot_made_flag == 'y'] = 'shot_yes'
green$shot_made_flag[green$shot_made_flag == 'n'] = 'shot_no'
green$shot_made_flag[green$shot_made_flag == 'y'] = 'shot_yes'
klay$shot_made_flag[klay$shot_made_flag == 'n'] = 'shot_no'
klay$shot_made_flag[klay$shot_made_flag == 'y'] = 'shot_yes'
durant$shot_made_flag[durant$shot_made_flag == 'n'] = 'shot_no'
durant$shot_made_flag[durant$shot_made_flag == 'y'] = 'shot_yes'
iguodala$shot_made_flag[iguodala$shot_made_flag == 'n'] = 'shot_no'
iguodala$shot_made_flag[iguodala$shot_made_flag == 'y'] = 'shot_yes'

curry$minute = curry$period * 12 - curry$minutes_remaining
green$minute = green$period * 12 - green$minutes_remaining
klay$minute = klay$period * 12 - klay$minutes_remaining
durant$minute = durant$period * 12 - durant$minutes_remaining
iguodala$minute = iguodala$period * 12 - iguodala$minutes_remaining

sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()
sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()
sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()
sink(file = '../output/klay-thompson-summary.txt')
summary(klay)
sink()
sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

combined <- rbind(curry, durant, green, iguodala, klay)

write.csv(
  x = combined,
  file = '../data/shots-data.csv')

sink(file = '../output/shots-data-summary.txt')
summary(combined)
sink()
