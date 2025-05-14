#include <stdio.h>

#define MAX_PROCESSES 10
#define MAX_RESOURCES 10

int P, R; // Number of processes and resources
int allocation[MAX_PROCESSES][MAX_RESOURCES];
int max[MAX_PROCESSES][MAX_RESOURCES];
int available[MAX_RESOURCES]; 
int need[MAX_PROCESSES][MAX_RESOURCES];
int finished[MAX_PROCESSES] = {0}, safeSequence[MAX_PROCESSES];

// Function to check if the system is in a safe state
int isSafe() {
    int count = 0;

    // Calculate the need matrix
    for (int i = 0; i < P; i++) {
        for (int j = 0; j < R; j++) {
            need[i][j] = max[i][j] - allocation[i][j];
        }
    }

    while (count < P) {
        int found = 0;
        for (int i = 0; i < P; i++) {
            if (finished[i] == 0) { // If process is not finished
                int j;
                for (j = 0; j < R; j++) {
                    if (need[i][j] > available[j])
                        break;
                }

                if (j == R) { // If all needs can be satisfied
                    for (int k = 0; k < R; k++)
                        available[k] += allocation[i][k];

                    safeSequence[count++] = i;
                    finished[i] = 1;
                    found = 1;
                }
            }
        }
        if (found == 0) {
            return 0; // System is in an unsafe state
        }
    }
    return 1; // System is in a safe state
}

// Function to print the safe sequence
void printSafeSequence() {
    printf("System is in a safe state.\nSafe Sequence: ");
    for (int i = 0; i < P; i++)
        printf("P%d ", safeSequence[i]);
    printf("\n");
}

int main() {
    // Taking input from the user
    printf("Enter the number of processes: ");
    scanf("%d", &P);
    printf("Enter the number of resources: ");
    scanf("%d", &R);

    // Input allocation matrix
    printf("Enter the allocation matrix:\n");
    for (int i = 0; i < P; i++) {
        for (int j = 0; j < R; j++) {
            scanf("%d", &allocation[i][j]);
        }
    }

    // Input max matrix
    printf("Enter the maximum demand matrix:\n");
    for (int i = 0; i < P; i++) {
        for (int j = 0; j < R; j++) {
            scanf("%d", &max[i][j]);
        }
    }

    // Input available resources
    printf("Enter the available resources: ");
    for (int i = 0; i < R; i++) {
        scanf("%d", &available[i]);
    }

    if (isSafe()) {
        printSafeSequence();
    } else {
        printf("System is in an unsafe state!\n");
    }

    return 0;
}