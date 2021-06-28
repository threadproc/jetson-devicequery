package main

import (
	"log"
	"net/http"
	"os/exec"
	"sync"
)

var mx sync.Mutex

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	// run /usr/local/bin/deviceQuery
	mx.Lock()
	defer mx.Unlock()

	cmd := exec.Command("/tmp/samples/1_Utilities/deviceQuery/deviceQuery")
	out, err := cmd.CombinedOutput()
	if err != nil {
		w.WriteHeader(500)
		w.Write([]byte("Error: " + err.Error()))
		return
	}

	w.Write(out)
}
