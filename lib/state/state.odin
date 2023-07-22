package state

import mu "lib:microui"
import "core:intrinsics"
import "core:reflect"

@private
type_is_struct_of_proc :: proc($T: typeid) -> bool 
    where intrinsics.type_is_struct(T) {
    for type in reflect.struct_field_types(T) {
        assert(reflect.is_procedure(type), "struct fields must be procs")
    }
    return true
}

get :: proc($S: typeid, $SoP: typeid) -> []SoP
    where intrinsics.type_is_enum(S) && intrinsics.type_is_struct(SoP) {

    type_is_struct_of_proc(SoP)
    @(static) table := [len(S)]SoP{}
    return table[:]
}

StateProc :: struct {
    enter: proc(),
    exit: proc(),
    tick: proc(),
    draw: proc(),
    draw_ui: proc(^mu.Context),
}