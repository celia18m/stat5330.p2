library(plyr)
# add interaction terms
newtrain <- mutate(train,
                   bone_flesh = bone_length * rotting_flesh,
                   bone_hair = bone_length * hair_length,
                   bone_soul = bone_length * has_soul,
                   flesh_hair = rotting_flesh * hair_length,
                   flesh_soul = rotting_flesh * has_soul,
                   hair_soul = hair_length * has_soul)

newtest <- mutate(test,
                  bone_flesh = bone_length * rotting_flesh,
                  bone_hair = bone_length * hair_length,
                  bone_soul = bone_length * has_soul,
                  flesh_hair = rotting_flesh * hair_length,
                  flesh_soul = rotting_flesh * has_soul,
                  hair_soul = hair_length * has_soul)

# delete the original variables
newtrain <- newtrain[, -c(1:5)]
newtest <- newtest[, -c(1:5)]
