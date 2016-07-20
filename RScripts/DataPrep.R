

# Set this to be the folder where raw data is stored.Get raw data from http://cricsheet.org/

setwd("C:/Users/admin/Downloads/Use_Case_Dhruv/t20_csv")  

#For refining data in order to remove initial details of a match in all csv files.
files <- list.files(pattern=".csv$")

t<-lapply(files, function(x){
  filex <- readLines(x)
  filex <- as.character(sapply(filex,function(y)if(!(grepl("info",y)||grepl("version",y)))return(y)))
  filex <- filex[filex!="NULL"]
  writeLines(filex,paste0("C://Users/admin/Downloads/Use_Case_Dhruv/Refined_t20data/",x))
})
testfiles <- sample(files,round(0.2*length(files)))
trainfiles <- setdiff(files,testfiles)
traindf = do.call(rbind, lapply(trainfiles, function(x) read.csv(paste0("C://Users/admin/Downloads/Use_Case_Dhruv/Refined_t20data/",x), header=FALSE,stringsAsFactors = FALSE)))


#For binding all csv files into one csv file.

filelist = list.files("E:\\UseCase\\Refined_ipldata")

lapply(1:length(filelist),function(x){
  prev = read.csv(paste0("E:\\UseCase\\Refined_ipldata\\",filelist[[x]]))
  colnames(prev) = c("Ball","Inning","Over","Team","StrikeBatsman",
                     "NonStrikeBatsman","Bowler","RunsScored","Extras","DismissalMethod",
                     "BatsmanOut")
  write.csv(prev,paste0("E:\\UseCase\\Refined_ipldata\\",filelist[[x]]),row.names = FALSE)
})

#To make it a global option.
FinalDataFrame=read.csv(paste0("E:\\UseCase\\Refined_ipldata\\",filelist[[1]]))

 for(x in 2:length(filelist)){
  temp = read.csv(paste0("E:\\UseCase\\Refined_ipldata\\",filelist[[x]]))
  FinalDataFrame = rbind(FinalDataFrame,temp)
}

write.csv(FinalDataFrame,"E:\\UseCase\\BindIPLData.csv")
