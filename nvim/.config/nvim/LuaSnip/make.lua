return {
	s(
		{ trig = ";mk", snippetType = "autosnippet" },
		fmt(
			[[
# ---------- Configuration ----------
SRC  := {}
EXEC := {}

CXX      := g++
CXXFLAGS := -std=c++20 -Wall -Wextra -O2

# ---------- Rules ----------
all: $(EXEC)

$(EXEC): $(SRC)
{}$(CXX) $(CXXFLAGS) $(SRC) -o $(EXEC)

run: $(EXEC)
{}./$(EXEC) < {}

clean:
{}rm -f $(EXEC)

.PHONY: all run clean
]],
			{
				i(1, "main.cpp"),
				i(2, "exe"),
				t("\t"),
				t("\t"),
				i(3, "input.txt"),
				t("\t"),
			}
		)
	),
}

