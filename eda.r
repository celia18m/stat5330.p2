library(ggplot2)
library(corrplot)

# correlation plot
corr<-cor(train[,1:4], method = "s")
corrplot(corr, method = "color", title = "Overall Correlation plot")

ggplot(train[train$type=="Ghost", ], aes(color), fill = type) + 
  geom_bar(stat="count", 
           fill = c("black", "firebrick", "steelblue4", "azure", "palegreen4", "ghostwhite"), 
           colour = "snow4",
           alpha = c(1,1,1,0,1,1)) + 
  labs(title = "Histogram of Ghost color") + 
  theme(plot.title = element_text(hjust = 0.5))

ggplot(train[train$type=="Ghoul", ], aes(color), fill = type) + 
  geom_bar(stat="count", 
           fill = c("black", "firebrick", "steelblue4", "azure", "palegreen4", "ghostwhite"), 
           colour = "snow4",
           alpha = c(1,1,1,0,1,1)) + 
  labs(title = "Histogram of Ghoul color") + 
  theme(plot.title = element_text(hjust = 0.5))

ggplot(train[train$type=="Goblin", ], aes(color), fill = type) + 
  geom_bar(stat="count", 
           fill = c("black", "firebrick", "steelblue4", "azure", "palegreen4", "ghostwhite"), 
           colour = "snow4",
           alpha = c(1,1,1,0,1,1)) + 
  labs(title = "Histogram of Goblin color") + 
  theme(plot.title = element_text(hjust = 0.5))

# for all numeric variables
library(GGally)
ggpairs(train[,c(2:5,7)], aes(colour = type, alpha = 0.4))

# color
ggplot(train, aes(x  = color, fill = type)) + 
  geom_bar(stat = 'count', position = 'dodge', colour='black') + 
  theme_bw() +
  theme(plot.title = element_text(hjust= 0.5)) + 
  ggtitle('Color vs Type') + scale_fill_brewer(palette = "Set2")
