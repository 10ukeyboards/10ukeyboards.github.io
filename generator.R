
library(gsheet)


## If using most R clients this will set the WD
#setwd(getSrcDirectory()[1])
## If using RStudio this will set the proper WD
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))




boards <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1yjBroqWsdkn6UIRHMhAu7uRpc40q9PTtaTIKJLjE-6g/edit?usp=sharing")
boards <- boards[,-1]
fileConn <- file("docs//index.md")


str = "
---
title: 10u Keyboards
---

# Links


| Stagger | 4 Row | 3 Row | 5 Row |  
| --- | --- | --- | --- |
| Non-Split | [Row Stagger](#4nr), [Ortholinear](#4no), [Column Stagger](#3nc) | [Row Stagger](#3nr), [Ortholinear](#3no), [Column Stagger](#4nc) | [Row Stagger](#5nr), [Ortholinear](#5no), [Column Stagger](#5nc) |  
| Unibody Split | [Row Stagger](#4nr), [Ortholinear](#4no), [Column Stagger](#4nc) | [Row Stagger](#3nr), [Ortholinear](#3no), [Column Stagger](#3nc) | [Row Stagger](#5nr), [Ortholinear](#5no), [Column Stagger](#5nc) |  
| Split | [Row Stagger](#4nr), [Ortholinear](#4no), [Column Stagger](#4nc) | [Row Stagger](#3nr), [Ortholinear](#3no), [Column Stagger](#3nc) | [Row Stagger](#5nr), [Ortholinear](#5no), [Column Stagger](#5nc) |  
[Chorded](#chord)  



# Keyboard List


"

for(rows in c(3,4,5)){
  for(style in c("Nonsplit","Unibody Split","Split")){
    for(stagger in c("Row Stagger","Ortholinear","Column Stagger")){
      str = paste(str,"## ",rows," Rows, ",style,", ",stagger," <a name=\"",rows,tolower(unlist(strsplit(style,""))[1]),tolower(unlist(strsplit(stagger,""))[1]),"\"></a>  \n",sep="")
      str = paste(str,"| |  \n","| :---: |  \n",sep="")  
      numberBoards <- dim(boards[,1])[1]
      for(i in 1:numberBoards){
        if(boards[i,2]==rows && boards[i,3]==style && boards[i,4]==stagger){
          print(boards[i,1])
          str = paste(str,"| **",boards[i,1],"** <br> [Info](",boards[i,5],") <br> <img src=\"",boards[i,6],"\" alt=\"",boards[i,1],"\" width=\"300\"/> <br> Image Credit: ",boards[i,7]," |  \n",sep="")
        }
      }#End Cycle the Boards
      str = paste(str,"\n\n",sep="")    
    }#End Stagger
  }#end split
}#end rows



write(str,fileConn)

close(fileConn)

