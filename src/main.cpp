#include <iostream>
#include <string>

namespace {
  void prepare_shell() {
  // Flush after every std::cout / std:cerr
  std::cout << std::unitbuf;
  std::cerr << std::unitbuf;
  std::cout << "$ ";
  }

  std::string read_input() {
    std::string buffer;
    std::getline(std::cin, buffer);
    return buffer;
  }

  void print_input(const std::string& input) {
    std::cout << input << ": command not found" << std::endl;
  }
}


int main() {
  prepare_shell();
  print_input(read_input());
}
