// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        Todo memory todo = Todo({text: _text, completed: false});
        todos.push(todo);
    }

    function updateText(uint256 _index, string calldata _text) external {
        require(_index >= 0 && _index < todos.length, "index out of range");
        todos[_index].text = _text;
    }

    function toggleCompleted(uint256 _index) external {
        require(_index >= 0 && _index < todos.length, "index out of range");
        todos[_index].completed = !todos[_index].completed;
    }

    function get(uint256 _index) external view returns (string memory, bool) {
        require(_index >= 0 && _index < todos.length, "index out of range");
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }
}
