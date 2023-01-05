package main

import (
	"fmt"
	"os"
	"os/user"
)

func main() {
	fmt.Println("User id:", os.Getuid())
	var u *user.User
	u, _ = user.Current()
	fmt.Print("Group ids: ")
	groupIds, _ := u.GroupIds()
	for _, id := range groupIds {
		fmt.Print(id, " ")
	}
	fmt.Println()
}
