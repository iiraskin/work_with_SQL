#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "sqlite3.h"

int main()
{
    sqlite3 *db = 0;
    const char *tail;
    sqlite3_stmt *st;

    if( sqlite3_open( "TrainBD.sqlite", &db ) ) {
        fprintf( "Can't open database: %s\n", sqlite3_errmsg( db ) );
        sqlite3_close( db );
        return 1;
    }
    //Создание таблиц.
    char buf[20000];
    char* command = buf;
    command[0] = 0;
    char* command1 = malloc( 1025 );
    command1[0] = 0;
    int fd = open( "CREATION.SQL", O_RDONLY | O_BINARY );
    int resRead;
    do {
        resRead = read( fd, command1, 1024 );
        command1[resRead] = 0;
        command = strcat( command, command1 );
    } while( resRead == 1024 );
    //printf( "%s\n", command );
    close( fd );
    if( sqlite3_prepare( db, command, -1, &st, &tail ) != SQLITE_OK ) {
        printf( "%s\n", sqlite3_errmsg( db ) );
        sqlite3_close( db );
        return 2;
    }
    if( sqlite3_step( st ) != SQLITE_DONE ) {
        sqlite3_close( db );
        return 3;
    }
    while( tail[0] ) {
        if( sqlite3_prepare( db, tail, -1, &st, &tail ) != SQLITE_OK ) {
            printf( "%s\n", sqlite3_errmsg( db ) );
            sqlite3_close( db );
            return 2;
        }
        if( sqlite3_step( st ) != SQLITE_DONE ) {
            sqlite3_close( db );
            return 3;
        }
	sqlite3_finalize( st );
    }
    
    //Пример запроса.
    if( sqlite3_prepare( db, "SELECT * FROM Carriages WHERE id_car_tr = ? ORDER BY id_car;",
                         -1, &st, &tail ) != SQLITE_OK || tail[0] ) {
        printf( "%s\n", sqlite3_errmsg( db ) );
        sqlite3_close( db );
        return 4;
    }
    int num;
    printf( "Input number of train\n" );
    //Советую ввести 234.
    scanf( "%d", &num );
    if( sqlite3_bind_int( st, 1, num ) != SQLITE_OK ) {
        printf( "%s\n", sqlite3_errmsg( db ) );
        sqlite3_close( db );
        return 5;
    }
    while( sqlite3_step( st ) == SQLITE_ROW )
    {
        printf( "id_car: %d, car_number: %d, cargo: %s, cargo_weight: %d\n", sqlite3_column_int( st, 0 ),
               sqlite3_column_int( st, 2 ), sqlite3_column_text( st, 3 ), sqlite3_column_int( st, 4 ) ) ;
    }
    sqlite3_finalize( st );

    sqlite3_close( db );
    return 0;
}

