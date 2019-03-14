##Title: Data Visualization
##Description: Visualizing the shots data per player
##Inputs: Aggregated shot data
##Output: png and pdf shot images for each player


library(jpeg)
library(grid)
library(ggplot2)
library(dplyr)
# court image (to be used as background of plot)
court_file <- "../images/nba-court.jpg"
# create raste object
court_image <- rasterGrob( readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

combined <- read.csv("../data/shots-data.csv", stringsAsFactors = FALSE)
curry = combined[combined$name == 'Stephen Curry', ]
klay= combined[combined$name == 'Klay Thompson', ]
green = combined[combined$name == 'Draymond Green', ]
durant = combined[combined$name == 'Kevin Durant', ]
iguodala = combined[combined$name == 'Andre Iguodala', ]

klay_shot_chart <- ggplot(data = klay) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()
ggsave('../images/klay-thompson-shot-chart.pdf', plot = klay_shot_chart, width = 6.5, height = 5, units = c("in"),)

curry_shot_chart <- ggplot(data = curry) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal()
ggsave('../images/stephen-curry-shot-chart.pdf', plot = curry_shot_chart, width = 6.5, height = 5, units = c("in"),)
       
green_shot_chart <- ggplot(data = green) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') + theme_minimal()
ggsave('../images/draymond-green-shot-chart.pdf', plot = green_shot_chart, width = 6.5, height = 5, units = c("in"),)

durant_shot_chart <- ggplot(data = durant) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + theme_minimal()
ggsave('../images/kevin-durant-shot-chart.pdf', plot = durant_shot_chart, width = 6.5, height = 5, units = c("in"),)

iguodala_shot_chart <- ggplot(data = iguodala) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + theme_minimal()
ggsave('../images/andre-iguodala-shot-chart.pdf', plot = iguodala_shot_chart, width = 6.5, height = 5, units = c("in"),)




shot_chart <- ggplot(data = combined) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') + 
  theme_minimal() +
  facet_wrap(~name)
ggsave('../images/gsw-shot-charts.pdf', plot = shot_chart, width = 8, height = 7, units = c("in"),)
ggsave('../images/gsw-shot-charts.png', plot = shot_chart, width = 8, height = 7, units = c("in"),)
