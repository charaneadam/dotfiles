return {
	s(
		{ trig = ";env", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
			}
		)
	),

	s(
		{ trig = ";item", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{itemize}
          \item <>
      \end{itemize}
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";enum", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{enumerate}
          \item <>
      \end{enumerate}
    ]],
			{
				i(0),
			}
		)
	),
}
