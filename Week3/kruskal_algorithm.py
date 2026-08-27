# Kruskal's Algorithm in Python

def find(parent, i):
    if parent[i] != i:
        parent[i] = find(parent, parent[i])
    return parent[i]


def union(parent, rank, x, y):
    root_x = find(parent, x)
    root_y = find(parent, y)

    if rank[root_x] < rank[root_y]:
        parent[root_x] = root_y

    elif rank[root_x] > rank[root_y]:
        parent[root_y] = root_x

    else:
        parent[root_y] = root_x
        rank[root_x] += 1


def kruskal(vertices, edges):
    # Sort edges according to weight
    edges.sort(key=lambda x: x[2])

    parent = []
    rank = []

    for i in range(vertices):
        parent.append(i)
        rank.append(0)

    mst = []
    total_cost = 0

    for u, v, weight in edges:
        root_u = find(parent, u)
        root_v = find(parent, v)

        # Add edge only if it doesn't form a cycle
        if root_u != root_v:
            mst.append((u, v, weight))
            total_cost += weight
            union(parent, rank, root_u, root_v)

        # MST has V-1 edges
        if len(mst) == vertices - 1:
            break

    print("Edges in Minimum Spanning Tree:")

    for u, v, weight in mst:
        print(u, "--", v, "=", weight)

    print("Total cost:", total_cost)


# Number of vertices
vertices = 4

# Edges: (vertex1, vertex2, weight)
edges = [
    (0, 1, 10),
    (0, 2, 6),
    (0, 3, 5),
    (1, 3, 15),
    (2, 3, 4)
]

kruskal(vertices, edges)