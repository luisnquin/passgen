package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/pedr0rocha/password-generator-cli/password"
)

func main() {
	passLength, hasSymbols := 32, true

	flag.IntVar(&passLength, "length", passLength, "Password length")
	flag.IntVar(&passLength, "l", passLength, "Shorthand for --length")
	flag.BoolVar(&hasSymbols, "symbols", hasSymbols, "Indicates if the password should contain symbols")
	flag.BoolVar(&hasSymbols, "s", hasSymbols, "Shorthand for --symbols")
	flag.Parse()

	result, err := password.Generate(passLength, hasSymbols)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Fprintf(os.Stdout, "%s\n", result)
}
