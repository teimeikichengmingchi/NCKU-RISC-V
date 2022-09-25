#include <stdio.h>
#include <stdlib.h>

int removeDuplicates(int* nums, int numSize);

int main(){
    
    int nums1[] = {0,0,0,1,1,2,3,4,4,4,5,6,7,7,7};
    int cnt = removeDuplicates(nums1, 15);
    for(int i = 0; i < cnt; i++)
        printf("%d ", nums1[i]);
    printf("\n");

    int nums2[] = {-7,-7,0,1,1,3,3,4,4,4,5,5,5,6};
    cnt = removeDuplicates(nums2, 14);
    for(int i = 0; i < cnt; i++)
        printf("%d ", nums2[i]);
    printf("\n");

    int nums3[] = {-1,0,0,1,1,2,3,4,4,4,5,6,7,7,7,8,9,10,11,11,11};
    cnt = removeDuplicates(nums3, 21);
    for(int i = 0; i < cnt; i++)
        printf("%d ", nums3[i]);
    printf("\n");
    
    return 0;
}

int removeDuplicates(int* nums, int numSize){
    int shift = 0;
    for(int i = 1; i < numSize; i++){
        if(nums[i] == nums[i - 1])
            shift++;
        else
            nums[i - shift] = nums[i];
    }
    return numSize - shift;
}
