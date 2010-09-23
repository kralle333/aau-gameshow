#include <windows.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

//List of key kodes:
//http://msdn.microsoft.com/en-us/library/dd375731%28v=VS.85%29.aspx
void keyAction1( BOOL bState, int keyID ){
    BYTE keyState[256];
    GetKeyboardState((LPBYTE)&keyState);
    if( (bState && !(keyState[keyID] & 1)) ||
    (!bState && (keyState[keyID] & 1)) ){
        // Simulate a key press
        keybd_event( keyID,0x45,KEYEVENTF_EXTENDEDKEY | 0,0 );
usleep(50000);
        // Simulate a key release
        keybd_event( keyID,0x45,KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP,0);
    }
}


int main(int argc, char *argv[])
{
   DCB dcb;
   HANDLE hCom;
   BOOL fSuccess;
   char *pcCommPort = "COM5";

   hCom = CreateFile( pcCommPort,
                    GENERIC_READ | GENERIC_WRITE,
                    0,    // must be opened with exclusive-access
                    NULL, // no security attributes
                    OPEN_EXISTING, // must use OPEN_EXISTING
                    0,    // not overlapped I/O
                    NULL  // hTemplate must be NULL for comm devices
                    );

   if (hCom == INVALID_HANDLE_VALUE)
   {
       // Handle the error.
       printf ("CreateFile failed with error %d.\n", (int)GetLastError());
       return (1);
   }

   // Build on the current configuration, and skip setting the size
   // of the input and output buffers with SetupComm.

   fSuccess = GetCommState(hCom, &dcb);

   if (!fSuccess)
   {
      // Handle the error.
      printf ("GetCommState failed with error %d.\n", (int)GetLastError());
      return (2);
   }

   // Fill in DCB: 9600 bps, 8 data bits, no parity, and 1 stop bit.

   dcb.BaudRate = CBR_9600;     // set the baud rate
   dcb.ByteSize = 8;             // data size, xmit, and rcv
   dcb.Parity = NOPARITY;        // no parity bit
   dcb.StopBits = ONESTOPBIT;    // one stop bit

   fSuccess = SetCommState(hCom, &dcb);

   if (!fSuccess)
   {
      // Handle the error.
      printf ("SetCommState failed with error %d.\n", (int)GetLastError());
      return (3);
   }

   printf ("Serial port %s successfully reconfigured.\n", pcCommPort);

   char szBuff[2] = {0};

   DWORD myBytesRead = 0;

    int count = 0;

   while(1){
        //usleep(10000);
        ReadFile(hCom, szBuff, 2, &myBytesRead, NULL);
        if(myBytesRead==2){
            //A-B
            if((char)szBuff[0]=='B'){

                keyAction1( TRUE, 'Z' );
                //printf("\a");
            //}else if((char)szBuff[0]=='A'){
            //    keyAction1( TRUE, 'A' );
            }

            //X-Y
            if((char)szBuff[1]=='Y'){
                keyAction1( TRUE, 'X' );
                //printf("\a");
            //}else if((char)szBuff[1]=='X'){
            //    keyAction1( TRUE, 'X' );
            }
            count = 0;
        }

    }
   return (0);
}

