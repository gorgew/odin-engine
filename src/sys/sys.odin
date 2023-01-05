package sys

abort :: proc(message: string) {
    assert(false, message)
}