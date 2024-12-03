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

  s(
		{ trig = ";bf", snippetType = "autosnippet" },
		fmta(
			[[
      \textbf{<>}
    ]],
			{
				i(0),
			}
		)
	),

  s(
		{ trig = ";bb", snippetType = "autosnippet" },
		fmta(
			[[
      \mathbb{<>}
    ]],
			{
				i(0),
			}
		)
	),

  s(
		{ trig = ";cal", snippetType = "autosnippet" },
		fmta(
			[[
      \mathcal{<>}
    ]],
			{
				i(0),
			}
		)
	),
}
