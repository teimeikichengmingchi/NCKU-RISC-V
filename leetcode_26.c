#include <stdio.h>
#include <stdlib.h>

int removeDuplicates(int* nums, int numSize);

int main(){
    int nums[] = {0,0,0,1,1,2,3,4,4,4,5,6,7,7,7};
    int cnt = removeDuplicates(nums, 15);
    for(int i = 0; i < cnt; i++)
        printf("%d ", nums[i]);
       return 0;
}

int removeDuplicates(int* nums, int numSize){
    int shift = 0;
    for(int i = 1; i < numSize; i++){
        if(nums[i] == nums[i - 1])
            shift++;
        nums[i - shift] = nums[i];
    }
    return numSize - shift;
}
