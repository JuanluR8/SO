#ifndef _MYTAR_H
#define _MYTAR_H

#include <limits.h>

typedef enum{
  NONE,
  ERROR,
  APPEND,
  INFO,
  CREATE,
  EXTRACT
} flags;

typedef struct {
  char* name;
  unsigned int size;
} stHeaderEntry;

int createTar(int nFiles, char *fileNames[], char tarName[]);
int extractTar(char tarName[]);
int infoTar(char tarName[]);
int appendTar(int nFiles, char *fileNames[], char tarName[]);



#endif /* _MYTAR_H */
