#include <iostream>
#include <cstdlib>
#include <sstream>
#include <cmath>
#include <string>
#include <iomanip>

using namespace std;

class Time{
    private:
        int hour, minute, second;
    public:
        Time(int hour, int minute, int second){
            if(hour >= 24) hour -= 24;
            this->hour = hour;
            if(minute >= 60) minute -= 60;
            this->minute = minute;
            if(second >= 60) second -= 60;
            this->second = second;
        }

        Time(int duration){
            hour = duration/(60*60);
            minute = (duration/60)%60;
            second = duration%60;
        }

        int getDuration(){
            return hour*60*60 + minute*60 + second;
        }

        Time add(Time other){
            Time tmp(this->hour, this->minute, this->second);
            tmp.second += other.second;
            if(tmp.second >= 60){
                tmp.minute += tmp.second/60;
                tmp.second = tmp.second%60;
            }
            tmp.minute += other.minute;
            if(tmp.minute >= 60){
                tmp.hour += tmp.minute/60;
                minute = tmp.minute%60;
            }
            tmp.hour += other.hour;
            if(tmp.hour >= 24){
                tmp.hour -= 24;
            }
            return tmp;
        }

        int subtract(Time other){
            int duration1 = this->getDuration();
            int duration2 = other.getDuration();
            int total = duration1 - duration2;
            if(total < 0){
                total += 24*60*60 ;
            }
            return total;
        }

        int equals(Time other){
            if(second == other.second && minute == other.minute && hour == other.hour)return 1;
            return 0;
        }

        string toString(){
            string s;
            if(this->hour < 10) s += "0" ;
            s += to_string(this->hour) + ":";
            if(this->minute < 10) s += "0";
            s += to_string(this->minute) + ":";
            if(this->second < 10) s += "0";
            s += to_string(this->second);
            return s;
        }

        int getHour(){return this->hour;}
        int getMinute(){return this->minute;}
        int getSecond(){return this->second;}
};

int main(){

    Time t1()

    return 0;
}